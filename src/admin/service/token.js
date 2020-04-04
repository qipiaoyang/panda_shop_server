const jwt = require('jsonwebtoken');
const secret = 'QiPiaoYang956634645***';

module.exports = class extends think.Service {

  constructor(){
    super();
  }

  /**
   * 根据header中的token值获取用户id
   */
  getUserInfo(token) {
    if (!token) return false;
    const result = this.parse(token);
    if (think.isEmpty(result)) return false;
    if (result.id <= 0) return false;
    return result;
  }

  create(userInfo) {
    const token = jwt.sign(userInfo, secret);
    return token;
  }

  parse(token) {
    if (!token) return null;
    try {
      return jwt.verify(token, secret);
    } catch (err) {
      return null;
    }
  }

  async verify(token) {
    const result = this.parse(token);
    return !think.isEmpty(result)
  }

};
