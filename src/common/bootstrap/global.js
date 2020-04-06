
/**
 * 密码加密
 * @param password 加密的密码
 * @param md5encoded true-密码不加密，默认加密
 * @returns {*}
 */
global.encryptPassword = function(password, md5encoded) {
  md5encoded = md5encoded || false;
  password = md5encoded ? password : think.md5(password);
  return think.md5(think.md5('panda') + password + think.md5('qi'));
};

/**
 * 列表转树
 * @param arr
 * @param pid
 * @returns {Array}
 */
global.arrayToTree = function(arr, pid) {
  let temp = [];
  let treeArr = arr;
  treeArr.forEach((item, index) => {
    if (item.pid == pid) {
      if (this.arrayToTree(treeArr, treeArr[index].id).length > 0) {
        // 递归调用此函数
        treeArr[index].children = this.arrayToTree(treeArr, treeArr[index].id);
      }
      temp.push(treeArr[index]);
    }
  });
  return temp;
}

/**
 * 获取时间戳
 * @returns {Number}
 */
global.getTime = function() {
  return new Date().getTime();
}
