module.exports = class extends think.Model {
    async getUser(option) {

        const data = await this.model("user").where(option).find();
        return data;
    }

};
