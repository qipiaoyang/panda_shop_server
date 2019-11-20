module.exports = class extends think.Model {
    async getList() {
        const data = await this.model("users").select();
        return data;
    }
    
};
