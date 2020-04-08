const BaseRest = require('./rest.js');

module.exports = class extends BaseRest {

    async getAction() {
        try {
            let data;
            if (this.id) {
                const pk = this.modelInstance.pk;
                data = await this.modelInstance.where({[pk]: this.id}).find();
                delete data.password;
                return this.success(data);
            }
            // 所有对象
            let order = this.get('order') || 'id ASC';
            let page = this.get('page');
            let title = this.get('title') || "";
            if (!page) {
                // 不传分页默认返回所有
                let where = null;
                if(think.isEmpty(title)) {
                    data = await this.modelInstance.where({
                        title: ['like', `%${title}%`]
                    }).order(order).select();
                } else {
                    data = await this.modelInstance.order(order).select();
                }
                return this.success(data);
            } else {
                // 传了分页返回分页数据
                let pageSize = this.get('size') || 10;
                if(think.isEmpty(title)) {
                    data = await this.modelInstance.where({
                        title: ['like', `%${title}%`]
                    }).page(page, pageSize).order(order).countSelect();
                } else {
                    data = await this.modelInstance.page(page, pageSize).order(order).countSelect();
                }
                return this.success(data);
            }
        } catch (e) {
            think.logger.error(new Error(e));
            return this.fail(500, "接口异常！");
        }
    }

    async postAction() {
        try {
            let data = this.post();
            if (think.isEmpty(data)) {
                return this.fail('data is empty');
            }
            if (think.isEmpty(data.mobile)) {
                return this.fail("请传入手机号");
            }
            if (think.isEmpty(data.password)) {
                return this.fail("请传入密码");
            }
            if (data.password) {
                data.password = encryptPassword(data.password);
                const hasUser = await this.modelInstance.where({mobile: data.mobile}).find();
                if (!think.isEmpty(hasUser)) {
                    return this.fail("该用户已存在～");
                }
            }
            data.reg_time = getTime();
            data.update_time = getTime();
            const insertId = await this.modelInstance.add(data);
            return this.success({id: insertId});
        } catch (e) {
            think.logger.error(new Error(e));
            return this.fail(500, "接口异常！");
        }

    }

    async putAction() {
        try {
            if (!this.id) {
                return this.fail('params error');
            }
            const pk = this.modelInstance.pk;
            const data = this.post();
            data[pk] = this.id;
            if (think.isEmpty(data)) {
                return this.fail('data is empty');
            }
            if (!think.isEmpty(data.mobile)) {
                const hasUser = await this.modelInstance.where({mobile: data.mobile, id: ['!=', this.id]}).find();
                if (!think.isEmpty(hasUser)) {
                    return this.fail("该手机号已存在～")
                }
            }

            data.password = encryptPassword(data.password);
            data.update_time = getTime();
            const rows = await this.modelInstance.where({[pk]: this.id}).update(data);
            return this.success({affectedRows: rows});

        } catch (e) {
            think.logger.error(new Error(e));
            return this.fail(500, "接口异常！");
        }
    }


};
