const BaseRest = require('./rest.js');

module.exports = class extends BaseRest {

  async postAction() {
    let data = this.post();
    if (think.isEmpty(data)) {
      return this.fail('data is empty');
    }
    if(think.isEmpty(data.mobile)) {
      return this.fail("请传入手机号");
    }
    if(data.password) {
      data.password = encryptPassword(data.password);
      const hasUser = await this.modelInstance.where({ mobile: data.mobile }).find();
      if(!think.isEmpty(hasUser)) {
        return this.fail("该用户已存在～")
      }
    }
    const insertId = await this.modelInstance.add(data);
    return this.success({ id: insertId });
  }

  async putAction() {
    if (!this.id) {
      return this.fail('params error');
    }
    const pk = this.modelInstance.pk;
    const data = this.post();
    data[pk] = this.id; // rewrite data[pk] forbidden data[pk] !== this.id
    if (think.isEmpty(data)) {
      return this.fail('data is empty');
    }

    const hasUser = await this.modelInstance.where({ mobile: data.mobile }).find();
    if(!think.isEmpty(hasUser)) {
      return this.fail("该手机号已存在～")
    }
    data.password = encryptPassword(data.password);
    const rows = await this.modelInstance.where({ [pk]: this.id }).update(data);
    return this.success({ affectedRows: rows });
  }



};
