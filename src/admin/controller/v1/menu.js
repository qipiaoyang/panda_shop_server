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
            let parent_id = this.get("parent_id");
            if (!page) {
                const map = {};
                if(!think.isEmpty(title)) {
                    map.title = ['like', `%${title}%`];
                }
                if(!think.isEmpty(parent_id)) {
                    map.parent_id = parent_id;
                }
                data = await this.modelInstance.where(map).order(order).select();
                return this.success(data);
            } else {
                // 传了分页返回分页数据
                let pageSize = this.get('size') || 10;
                if(think.isEmpty(title)) {
                    data = await this.modelInstance.page(page, pageSize).order(order).countSelect();
                } else {
                    data = await this.modelInstance.where({
                        title: ['like', `%${title}%`]
                    }).page(page, pageSize).order(order).countSelect();
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
            if (think.isEmpty(data.parent_id)) {
                return this.fail("请传入父级id");
            }
            if (think.isEmpty(data.title)) {
                return this.fail("请传入目录菜单");
            }
            if (think.isEmpty(data.name)) {
                return this.fail("请传入前端名称");
            }
            data.create_time = getTime();
            data.update_time = getTime();

            if(data.parent_id === 0) {
                data.level = 0;
            } else {
                data.level = 1;
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
            if (think.isEmpty(data.parent_id)) {
                return this.fail("请传入父级id");
            }
            if (think.isEmpty(data.title)) {
                return this.fail("请传入目录菜单");
            }
            if (think.isEmpty(data.name)) {
                return this.fail("请传入前端名称");
            }
            data.update_time = getTime();
            const rows = await this.modelInstance.where({[pk]: this.id}).update(data);
            return this.success({affectedRows: rows});

        } catch (e) {
            think.logger.error(new Error(e));
            return this.fail(500, "接口异常！");
        }
    }


};
