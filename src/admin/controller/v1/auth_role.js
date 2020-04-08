const BaseRest = require('./rest.js');

module.exports = class extends BaseRest {

    async getAction() {
        try {
            let data;
            if (this.id) {
                const pk = this.modelInstance.pk;
                data = await this.modelInstance.where({[pk]: this.id}).find();
                return this.success(data);
            }
            // 所有对象
            let order = this.get('order') || 'id ASC';
            let page = this.get('page');
            let desc = this.get('desc') || "";
            if (!page) {
                // 不传分页默认返回所有
                data = await this.modelInstance.where({
                    desc: ['like', `%${desc}%`]
                }).order(order).select();
                return this.success(data);
            } else {
                // 传了分页返回分页数据
                let pageSize = this.get('size') || 10;
                data = await this.modelInstance.where({
                    desc: ['like', `%${desc}%`]
                }).page(page, pageSize).order(order).countSelect();
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
            data.module = "admin";
            data.type = 1;
            data.status = 1;
            if (think.isEmpty(data)) {
                return this.fail('data is empty');
            }
            if (think.isEmpty(data.desc)) {
                return this.fail("请传入角色名称");
            }
            const hasUser = await this.modelInstance.where({desc: data.desc}).find();
            if (!think.isEmpty(hasUser)) {
                return this.fail("该角色已存在～")
            }
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
            if (!think.isEmpty(data.desc)) {
                const hasUser = await this.modelInstance.where({desc: data.desc, id: ['!=', this.id]}).find();
                if (!think.isEmpty(hasUser)) {
                    return this.fail("该角色已存在～")
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
