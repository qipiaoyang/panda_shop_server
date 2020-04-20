module.exports = class extends think.Model {
    async getUser(option) {

        const data = await this.model("admin").where(option).find();
        return data;
    }

};
