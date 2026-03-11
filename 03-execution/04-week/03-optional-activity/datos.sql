\c cafetin;

-- Activar extension UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- TYPE DOCUMENT

INSERT INTO type_document (name,description) VALUES
('CC','Cedula de ciudadania'),
('TI','Tarjeta de identidad'),
('CE','Cedula extranjeria'),
('PAS','Pasaporte'),
('NIT','Numero tributario'),
('DOC1','Documento 1'),
('DOC2','Documento 2'),
('DOC3','Documento 3'),
('DOC4','Documento 4'),
('DOC5','Documento 5');


-- PERSON

INSERT INTO person (type_document_id,document_number,first_name,last_name,email,phone) VALUES
((SELECT id FROM type_document LIMIT 1),'1001','Juan','Perez','juan@mail.com','300000001'),
((SELECT id FROM type_document LIMIT 1),'1002','Ana','Gomez','ana@mail.com','300000002'),
((SELECT id FROM type_document LIMIT 1),'1003','Luis','Rodriguez','luis@mail.com','300000003'),
((SELECT id FROM type_document LIMIT 1),'1004','Maria','Lopez','maria@mail.com','300000004'),
((SELECT id FROM type_document LIMIT 1),'1005','Carlos','Diaz','carlos@mail.com','300000005'),
((SELECT id FROM type_document LIMIT 1),'1006','Laura','Ramirez','laura@mail.com','300000006'),
((SELECT id FROM type_document LIMIT 1),'1007','Pedro','Torres','pedro@mail.com','300000007'),
((SELECT id FROM type_document LIMIT 1),'1008','Camila','Rojas','camila@mail.com','300000008'),
((SELECT id FROM type_document LIMIT 1),'1009','David','Castro','david@mail.com','300000009'),
((SELECT id FROM type_document LIMIT 1),'1010','Sofia','Vargas','sofia@mail.com','300000010');


-- ROLE

INSERT INTO role (name,description) VALUES
('Admin','Administrador sistema'),
('Manager','Gerente'),
('Seller','Vendedor'),
('Customer','Cliente'),
('Supplier','Proveedor'),
('Role6','Rol 6'),
('Role7','Rol 7'),
('Role8','Rol 8'),
('Role9','Rol 9'),
('Role10','Rol 10');


-- MODULE

INSERT INTO module (name,description) VALUES
('Usuarios','Gestion usuarios'),
('Inventario','Gestion inventario'),
('Ventas','Gestion ventas'),
('Facturacion','Gestion facturacion'),
('Reportes','Reportes sistema'),
('Modulo6','Modulo 6'),
('Modulo7','Modulo 7'),
('Modulo8','Modulo 8'),
('Modulo9','Modulo 9'),
('Modulo10','Modulo 10');


-- VIEW MODULE

INSERT INTO view_module (name,module_id,description) VALUES
('Vista1',(SELECT id FROM module LIMIT 1),'Vista modulo'),
('Vista2',(SELECT id FROM module LIMIT 1),'Vista modulo'),
('Vista3',(SELECT id FROM module LIMIT 1),'Vista modulo'),
('Vista4',(SELECT id FROM module LIMIT 1),'Vista modulo'),
('Vista5',(SELECT id FROM module LIMIT 1),'Vista modulo'),
('Vista6',(SELECT id FROM module LIMIT 1),'Vista modulo'),
('Vista7',(SELECT id FROM module LIMIT 1),'Vista modulo'),
('Vista8',(SELECT id FROM module LIMIT 1),'Vista modulo'),
('Vista9',(SELECT id FROM module LIMIT 1),'Vista modulo'),
('Vista10',(SELECT id FROM module LIMIT 1),'Vista modulo');


-- CATEGORY

INSERT INTO category (name) VALUES
('Bebidas'),
('Comida'),
('Aseo'),
('Tecnologia'),
('Ropa'),
('Categoria6'),
('Categoria7'),
('Categoria8'),
('Categoria9'),
('Categoria10');


-- SUPPLIER

INSERT INTO supplier (person_id) VALUES
((SELECT id FROM person LIMIT 1)),
((SELECT id FROM person OFFSET 1 LIMIT 1)),
((SELECT id FROM person OFFSET 2 LIMIT 1)),
((SELECT id FROM person OFFSET 3 LIMIT 1)),
((SELECT id FROM person OFFSET 4 LIMIT 1)),
((SELECT id FROM person OFFSET 5 LIMIT 1)),
((SELECT id FROM person OFFSET 6 LIMIT 1)),
((SELECT id FROM person OFFSET 7 LIMIT 1)),
((SELECT id FROM person OFFSET 8 LIMIT 1)),
((SELECT id FROM person OFFSET 9 LIMIT 1));


-- PRODUCT

INSERT INTO product (name,price,category_id,supplier_id) VALUES
('Producto1',1000,(SELECT id FROM category LIMIT 1),(SELECT id FROM supplier LIMIT 1)),
('Producto2',2000,(SELECT id FROM category LIMIT 1),(SELECT id FROM supplier LIMIT 1)),
('Producto3',3000,(SELECT id FROM category LIMIT 1),(SELECT id FROM supplier LIMIT 1)),
('Producto4',4000,(SELECT id FROM category LIMIT 1),(SELECT id FROM supplier LIMIT 1)),
('Producto5',5000,(SELECT id FROM category LIMIT 1),(SELECT id FROM supplier LIMIT 1)),
('Producto6',6000,(SELECT id FROM category LIMIT 1),(SELECT id FROM supplier LIMIT 1)),
('Producto7',7000,(SELECT id FROM category LIMIT 1),(SELECT id FROM supplier LIMIT 1)),
('Producto8',8000,(SELECT id FROM category LIMIT 1),(SELECT id FROM supplier LIMIT 1)),
('Producto9',9000,(SELECT id FROM category LIMIT 1),(SELECT id FROM supplier LIMIT 1)),
('Producto10',10000,(SELECT id FROM category LIMIT 1),(SELECT id FROM supplier LIMIT 1));


-- INVENTORY

INSERT INTO inventory (product_id,quantity) VALUES
((SELECT id FROM product LIMIT 1),10),
((SELECT id FROM product OFFSET 1 LIMIT 1),15),
((SELECT id FROM product OFFSET 2 LIMIT 1),20),
((SELECT id FROM product OFFSET 3 LIMIT 1),25),
((SELECT id FROM product OFFSET 4 LIMIT 1),30),
((SELECT id FROM product OFFSET 5 LIMIT 1),35),
((SELECT id FROM product OFFSET 6 LIMIT 1),40),
((SELECT id FROM product OFFSET 7 LIMIT 1),45),
((SELECT id FROM product OFFSET 8 LIMIT 1),50),
((SELECT id FROM product OFFSET 9 LIMIT 1),55);


-- CUSTOMER

INSERT INTO customer (person_id) VALUES
((SELECT id FROM person LIMIT 1)),
((SELECT id FROM person OFFSET 1 LIMIT 1)),
((SELECT id FROM person OFFSET 2 LIMIT 1)),
((SELECT id FROM person OFFSET 3 LIMIT 1)),
((SELECT id FROM person OFFSET 4 LIMIT 1)),
((SELECT id FROM person OFFSET 5 LIMIT 1)),
((SELECT id FROM person OFFSET 6 LIMIT 1)),
((SELECT id FROM person OFFSET 7 LIMIT 1)),
((SELECT id FROM person OFFSET 8 LIMIT 1)),
((SELECT id FROM person OFFSET 9 LIMIT 1));


-- CUSTOMER ORDER

INSERT INTO customer_order (customer_id,total) VALUES
((SELECT id FROM customer LIMIT 1),20000),
((SELECT id FROM customer OFFSET 1 LIMIT 1),25000),
((SELECT id FROM customer OFFSET 2 LIMIT 1),30000),
((SELECT id FROM customer OFFSET 3 LIMIT 1),35000),
((SELECT id FROM customer OFFSET 4 LIMIT 1),40000),
((SELECT id FROM customer OFFSET 5 LIMIT 1),45000),
((SELECT id FROM customer OFFSET 6 LIMIT 1),50000),
((SELECT id FROM customer OFFSET 7 LIMIT 1),55000),
((SELECT id FROM customer OFFSET 8 LIMIT 1),60000),
((SELECT id FROM customer OFFSET 9 LIMIT 1),65000);


-- ORDER ITEM

INSERT INTO order_item (order_id,product_id,quantity,price) VALUES
((SELECT id FROM customer_order LIMIT 1),(SELECT id FROM product LIMIT 1),2,2000),
((SELECT id FROM customer_order OFFSET 1 LIMIT 1),(SELECT id FROM product LIMIT 1),3,3000),
((SELECT id FROM customer_order OFFSET 2 LIMIT 1),(SELECT id FROM product LIMIT 1),4,4000),
((SELECT id FROM customer_order OFFSET 3 LIMIT 1),(SELECT id FROM product LIMIT 1),1,1000),
((SELECT id FROM customer_order OFFSET 4 LIMIT 1),(SELECT id FROM product LIMIT 1),5,5000),
((SELECT id FROM customer_order OFFSET 5 LIMIT 1),(SELECT id FROM product LIMIT 1),2,2000),
((SELECT id FROM customer_order OFFSET 6 LIMIT 1),(SELECT id FROM product LIMIT 1),3,3000),
((SELECT id FROM customer_order OFFSET 7 LIMIT 1),(SELECT id FROM product LIMIT 1),4,4000),
((SELECT id FROM customer_order OFFSET 8 LIMIT 1),(SELECT id FROM product LIMIT 1),2,2000),
((SELECT id FROM customer_order OFFSET 9 LIMIT 1),(SELECT id FROM product LIMIT 1),1,1000);


-- METHOD PAYMENT

INSERT INTO method_payment (name) VALUES
('Efectivo'),
('Tarjeta credito'),
('Tarjeta debito'),
('Transferencia'),
('Nequi'),
('Daviplata'),
('Cheque'),
('Consignacion'),
('PSE'),
('Otro');


-- INVOICE

INSERT INTO invoice (order_id,total) VALUES
((SELECT id FROM customer_order LIMIT 1),20000),
((SELECT id FROM customer_order OFFSET 1 LIMIT 1),25000),
((SELECT id FROM customer_order OFFSET 2 LIMIT 1),30000),
((SELECT id FROM customer_order OFFSET 3 LIMIT 1),35000),
((SELECT id FROM customer_order OFFSET 4 LIMIT 1),40000),
((SELECT id FROM customer_order OFFSET 5 LIMIT 1),45000),
((SELECT id FROM customer_order OFFSET 6 LIMIT 1),50000),
((SELECT id FROM customer_order OFFSET 7 LIMIT 1),55000),
((SELECT id FROM customer_order OFFSET 8 LIMIT 1),60000),
((SELECT id FROM customer_order OFFSET 9 LIMIT 1),65000);


-- INVOICE ITEM

INSERT INTO invoice_item (invoice_id,product_id,quantity,price) VALUES
((SELECT id FROM invoice LIMIT 1),(SELECT id FROM product LIMIT 1),2,2000),
((SELECT id FROM invoice OFFSET 1 LIMIT 1),(SELECT id FROM product LIMIT 1),3,3000),
((SELECT id FROM invoice OFFSET 2 LIMIT 1),(SELECT id FROM product LIMIT 1),4,4000),
((SELECT id FROM invoice OFFSET 3 LIMIT 1),(SELECT id FROM product LIMIT 1),1,1000),
((SELECT id FROM invoice OFFSET 4 LIMIT 1),(SELECT id FROM product LIMIT 1),2,2000),
((SELECT id FROM invoice OFFSET 5 LIMIT 1),(SELECT id FROM product LIMIT 1),3,3000),
((SELECT id FROM invoice OFFSET 6 LIMIT 1),(SELECT id FROM product LIMIT 1),4,4000),
((SELECT id FROM invoice OFFSET 7 LIMIT 1),(SELECT id FROM product LIMIT 1),2,2000),
((SELECT id FROM invoice OFFSET 8 LIMIT 1),(SELECT id FROM product LIMIT 1),3,3000),
((SELECT id FROM invoice OFFSET 9 LIMIT 1),(SELECT id FROM product LIMIT 1),1,1000);


-- PAYMENT

INSERT INTO payment (invoice_id,method_payment_id,amount) VALUES
((SELECT id FROM invoice LIMIT 1),(SELECT id FROM method_payment LIMIT 1),20000),
((SELECT id FROM invoice OFFSET 1 LIMIT 1),(SELECT id FROM method_payment LIMIT 1),25000),
((SELECT id FROM invoice OFFSET 2 LIMIT 1),(SELECT id FROM method_payment LIMIT 1),30000),
((SELECT id FROM invoice OFFSET 3 LIMIT 1),(SELECT id FROM method_payment LIMIT 1),35000),
((SELECT id FROM invoice OFFSET 4 LIMIT 1),(SELECT id FROM method_payment LIMIT 1),40000),
((SELECT id FROM invoice OFFSET 5 LIMIT 1),(SELECT id FROM method_payment LIMIT 1),45000),
((SELECT id FROM invoice OFFSET 6 LIMIT 1),(SELECT id FROM method_payment LIMIT 1),50000),
((SELECT id FROM invoice OFFSET 7 LIMIT 1),(SELECT id FROM method_payment LIMIT 1),55000),
((SELECT id FROM invoice OFFSET 8 LIMIT 1),(SELECT id FROM method_payment LIMIT 1),60000),
((SELECT id FROM invoice OFFSET 9 LIMIT 1),(SELECT id FROM method_payment LIMIT 1),65000);