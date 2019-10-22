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
SELECT prod_name, prod_price FROM products WHERE prod_name = "fuses";






