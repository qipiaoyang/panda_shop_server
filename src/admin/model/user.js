module.exports = class extends think.Model {
    async getUser(option) {

        const data = await this.model("auth_user").where(option).find();
        return data;
    }

};
