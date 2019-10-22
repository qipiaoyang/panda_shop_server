module.exports = class extends think.Model {
    async getList() {
        const data = await this.model("users").query("SELECT * FROM orders");
        return data;
    }
    
};
