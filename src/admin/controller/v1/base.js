module.exports = class extends think.Controller {

  async __before() {
    this.ctx.state.token = this.ctx.header['token'] || '';
    const tokenSerivce = this.service('token');
    this.ctx.state.userInfo = await tokenSerivce.getUserInfo(this.ctx.state.token);

    // 获取所有开放方法
    const publicAction = this.config('publicAction');
    if (!publicAction.includes(this.ctx.url)) {

      if (this.ctx.state.userInfo.id <= 0) {
        return this.fail(401, '请先登录');
      }
      let userInfo = await this.getUserInfo();
      if (think.isEmpty(userInfo)) {
        return this.fail(401, '用户不存在，请先登录');
      } else {
        this.ctx.state.userInfo = userInfo;
      }
    }
  }

  async getUserInfo() {
    let userId = this.ctx.state.userInfo.id;
    if (think.isEmpty(userId)) return false;
    let userInfo = await this.model('auth_user').getUser({id: userId});
    if (think.isEmpty(userInfo)) return false;
    return userInfo;
  }

};
