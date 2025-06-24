// import_products.js
const admin = require('firebase-admin');
const fs = require('fs');

// 用你下载的密钥初始化
admin.initializeApp({
  credential: admin.credential.cert(
    require('./serviceAccountKey.json')
  ),
});

const db = admin.firestore();

(async () => {
  // 读你的 JSON 文件
  const raw = fs.readFileSync('products.json', 'utf8');
  const data = JSON.parse(raw);

  for (const p of data.products) {
    // 用 p.id 作为文档 ID，或者改成自动
    await db
      .collection('products')
      .doc(p.id.toString())
      .set(p);
    console.log('Imported product', p.id);
  }
  console.log('✅ All done');
  process.exit(0);
})().catch(err => {
  console.error(err);
  process.exit(1);
});
