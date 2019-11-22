-- SELECT prod_name from products;

-- SELECT prod_id, prod_name, prod_price FROM products;

-- SELECT vend_id FROM products;

-- 去重sql
-- SELECT DISTINCT vend_id FROM products; 

-- 限制返回结果条数
-- SELECT prod_name FROM products LIMIT 5;

-- 限制返回结果条数(第一个参数为起始行数，第二个是结果数)
-- SELECT prod_name FROM products LIMIT 5,5;

-- 完全限制表民
-- SELECT products.prod_name FROM school.products;

-- 排序子句(按照单个列排序)
-- SELECT prod_name FROM products ORDER BY prod_name;

-- 排序子句(按照多列排序,先按prod_price来排序，再按prod_name来)
-- SELECT prod_id, prod_price, prod_name FROM products ORDER BY prod_price, prod_name;

-- 排序指定排序方向
-- SELECT prod_id, prod_price, prod_name FROM products ORDER BY prod_price DESC, prod_name;

-- 查询最大值或者最小值(可以通过排序然后limit 1来进行处理)
-- SELECT prod_price FROM products ORDER BY prod_price DESC LIMIT 1;

-- 使用where过滤子句(使用ORDER BY 和 WHERE 语句的时候，应该让 WHERE 位于ORDER BY 之后)
-- SELECT prod_name, prod_price FROM products WHERE prod_price = 2.50 ORDER BY prod_name DESC;

-- MYSQL在执行匹配时默认是不区分大小写
-- SELECT prod_name, prod_price FROM products WHERE prod_name = "fuses";

-- 不匹配检查
-- SELECT vend_id, prod_name FROM products WHERE vend_id <> 1003;

-- 范围值检查
-- SELECT prod_name, prod_price FROM products WHERE prod_price BETWEEN 5 AND 10;

-- 空值检查
-- SELECT prod_name FROM products WHERE prod_price IS NULL;
-- SELECT cust_id FROM customers WHERE cust_email IS NULL;

-- 组合where字句AND
-- SELECT prod_id, prod_name, prod_price FROM products WHERE vend_id = 1003 AND prod_price <= 10;

-- 组合where子句OR
-- SELECT prod_name, prod_price, vend_id FROM products WHERE vend_id = 1002 OR vend_id = 1003;

-- 组合where子句顺序(AND 顺序优先于OR)
-- SELECT prod_name, prod_price FROM products WHERE (vend_id = 1002 OR vend_id = 1003) AND prod_price >= 10;

-- 组合where子句(in, not in) in比OR 执行速度更快，还可以包含where子句

-- SELECT prod_name, prod_price FROM products WHERE vend_id IN (1002, 1003);
-- SELECT prod_name, prod_price FROM products WHERE vend_id NOT IN (1002, 1003);

-- 使用正则表达式
-- SELECT prod_name FROM products WHERE prod_name REGEXP '1000|2000' ORDER BY prod_name;

-- 计算字段 concat
-- SELECT Concat(vend_name, "(" , vend_country, ")") AS test FROM vendors ORDER BY vend_name;







