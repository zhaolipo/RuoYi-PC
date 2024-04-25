// =======================================================
// 更换树形数组中对象的键
function renameKeys(array, oldKey, newKey) {
    return array.map(item => {
        const newItem = {};
        if (item[oldKey]) {
            newItem[newKey] = item[oldKey];
        }
        for (let key in item) {
            if (key !== oldKey && typeof item[key] === 'object' && item[key] !== null) {
                newItem[key] = renameKeys(item[key], oldKey, newKey);
            } else {
                newItem[key] = item[key];
            }
        }
        return newItem;
    });
}
// =======================================================
function getSexArray(){
    return [{text: '男性', value: '0'},{text: '女性', value: '1'},{text: '未知', value: '2'}]
}
// =======================================================
function getStatus(){
    return [{text: '正常', value: '0'},{text: '停用', value: '1'}]
}
// =======================================================
function getSucceed(){
    return [{text: '成功', value: '0'},{text: '失败', value: '1'}]
}
// =======================================================
function getBusinessType(){
    return [
        {text: '新增', value: '0'},
        {text: '修改', value: '1'},
        {text: '删除', value: '2'},
        {text: '授权', value: '3'},
        {text: '导出', value: '4'},
        {text: '导入', value: '5'},
        {text: '强退', value: '6'},
        {text: '生成代码', value: '7'},
        {text: '清空数据', value: '8'},
        {text: '其他', value: '9'}
    ]
}
// =======================================================