CREATE TABLE TIPO_USUARIO (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(255) NOT NULL
);

CREATE TABLE USUARIO (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_tipo INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    correo VARCHAR(255) NOT NULL,
    telefono VARCHAR(255) NOT NULL,
    contrasena VARCHAR(255) NOT NULL, -- Corrige el caracter no ASCII aquí
    FOREIGN KEY (id_tipo) REFERENCES TIPO_USUARIO(id)
);

CREATE TABLE IDIOMA (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    idioma VARCHAR(255) NOT NULL
);

CREATE TABLE PAIS (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre_pais VARCHAR(255) NOT NULL
);

CREATE TABLE DIRECCION (
    id INT AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(255) NOT NULL,
    estado VARCHAR(255) NOT NULL,
    ciudad VARCHAR(255) NOT NULL,
    codigo_postal VARCHAR(255) NOT NULL,
    id_pais INT NOT NULL,
    FOREIGN KEY (id_pais) REFERENCES PAIS(id)
);

CREATE TABLE DIRECCION_USUARIO (
    id_usuario INT NOT NULL,
    id_direccion INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id),
    FOREIGN KEY (id_direccion) REFERENCES DIRECCION(id)
);

CREATE TABLE ESTADO_PRODUCTO (
    id INT AUTO_INCREMENT PRIMARY KEY,
    estado VARCHAR(255) NOT NULL
);

CREATE TABLE CATEGORIA_PRODUCTO (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_categoria_padre INT,
    nombre_categoria VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_categoria_padre) REFERENCES CATEGORIA_PRODUCTO(id)
);

CREATE TABLE PRODUCTO (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_categoria INT NOT NULL,
    nombre_producto VARCHAR(255) NOT NULL,
    descripcion_producto VARCHAR(255) NOT NULL,
    imagen_producto1 VARCHAR(255) NOT NULL,
    imagen_producto2 VARCHAR(255) NOT NULL,
    imagen_producto3 VARCHAR(255) NOT NULL,
    estado INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIA_PRODUCTO(id),
    FOREIGN KEY (estado) REFERENCES ESTADO_PRODUCTO(id)
);

CREATE TABLE ITEM_PRODUCTO (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    cantidad_disp INT NOT NULL,
    precio DOUBLE NOT NULL,
    estado INT NOT NULL,
    FOREIGN KEY (estado) REFERENCES ESTADO_PRODUCTO(id),
    FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id)
);

CREATE TABLE VARIACION (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(255) NOT NULL
);

CREATE TABLE OPCION_VARIACION (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_variacion INT NOT NULL,
    valor VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_variacion) REFERENCES VARIACION(id)
);

CREATE TABLE CONFIGURACION_PRODUCTO (
    id_item_producto INT NOT NULL,
    id_opcion_variacion INT NOT NULL,
    FOREIGN KEY (id_item_producto) REFERENCES ITEM_PRODUCTO(id),
    FOREIGN KEY (id_opcion_variacion) REFERENCES OPCION_VARIACION(id)
);

CREATE TABLE METODO_PAGO_USUARIO (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_usuario INT NOT NULL,
    numero_tarjeta VARCHAR(255) NOT NULL,
    cvv VARCHAR(255) NOT NULL,
    nombre_portador VARCHAR(255) NOT NULL,
    fecha_expiracion VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id)
);

CREATE TABLE CARRITO (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id)
);

CREATE TABLE CARRITO_ITEM (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_carrito INT NOT NULL,
    id_item_producto INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_carrito) REFERENCES CARRITO(id),
    FOREIGN KEY (id_item_producto) REFERENCES ITEM_PRODUCTO(id)
);

CREATE TABLE METODO_ENVIO (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    precio DOUBLE NOT NULL
);

CREATE TABLE ESTADO_ORDEN (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    estado VARCHAR(255) NOT NULL
);

CREATE TABLE ORDEN (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_usuario INT NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    id_metodo_pago INT NOT NULL,
    direccion_envio INT NOT NULL,
    metodo_envio INT NOT NULL,
    total_orden DOUBLE NOT NULL,
    estado_orden INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id),
    FOREIGN KEY (id_metodo_pago) REFERENCES METODO_PAGO_USUARIO(id),
    FOREIGN KEY (direccion_envio) REFERENCES DIRECCION(id),
    FOREIGN KEY (metodo_envio) REFERENCES METODO_ENVIO(id),
    FOREIGN KEY (estado_orden) REFERENCES ESTADO_ORDEN(id)
);

CREATE TABLE ORDEN_ITEM (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_item_producto INT NOT NULL,
    id_orden INT NOT NULL,
    cantidad INT NOT NULL,
    precio DOUBLE NOT NULL,
    FOREIGN KEY (id_orden) REFERENCES ORDEN(id),
    FOREIGN KEY (id_item_producto) REFERENCES ITEM_PRODUCTO(id)
);

CREATE TABLE PROMOCION (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    descuento_porcentaje DOUBLE NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_final DATE NOT NULL
);

CREATE TABLE PROMOCION_CATEGORIA (
    id_categoria INT NOT NULL,
    id_promocion INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIA_PRODUCTO(id),
    FOREIGN KEY (id_promocion) REFERENCES PROMOCION(id)
);

-- MANEJO DE BANCO Y TARJETAS
CREATE TABLE BANCO (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_cuenta_dueno BIGINT NOT NULL,
    nombre_dueno VARCHAR(255) NOT NULL,
    saldo DECIMAL(10, 2) NOT NULL
);

CREATE TABLE TARJETA (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre_tarjeta VARCHAR(255) NOT NULL,
    numero_tarjeta VARCHAR(16) NOT NULL,
    cvv VARCHAR(3) NOT NULL,
    fecha_vencimiento VARCHAR(7) NOT NULL, -- Formato 'MM/YYYY'
    id_banco INT NOT NULL,
    FOREIGN KEY (id_banco) REFERENCES BANCO(id)
);