
/**
 * 密码加密
 * @param password 加密的密码
 * @param md5encoded true-密码不加密，默认加密
 * @returns {*}
 */
global.encryptPassword = function(password, md5encoded) {
  md5encoded = md5encoded || false;
  password = md5encoded ? password : think.md5(password);
  return think.md5(think.md5('panda') + password + think.md5('qi'));
};
