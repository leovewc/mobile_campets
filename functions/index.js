/* eslint-disable */
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const SibApiV3Sdk = require("sib-api-v3-sdk");

admin.initializeApp();

const brevoApiKey = functions.config().brevo.key;
const templateId = Number(functions.config().brevo.template_id);

exports.sendResetWithBrevo = functions.https.onCall(
  async (data, context) => {
    const { email } = data;
    if (!email) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Email 必须提供"
      );
    }

    // 1) 生成重置链接
    const actionLink = await admin.auth().generatePasswordResetLink(
      email,
      {
        url: "https://yourapp.com/reset",
        handleCodeInApp: true,
      }
    );

    // 2) 调用 Brevo HTTP API 发邮件
    const apiInstance = new SibApiV3Sdk.TransactionalEmailsApi();
    apiInstance.setApiKey(
      SibApiV3Sdk.TransactionalEmailsApiApiKeys.apiKey,
      brevoApiKey
    );

    const sendSmtpEmail = {
      to: [{ email }],
      templateId,
      params: {
        user_email: email,
        action_url: actionLink,
      },
    };

    await apiInstance.sendTransacEmail(sendSmtpEmail);

    return { success: true };
  }
);
