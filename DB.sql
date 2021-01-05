-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-04-2018 a las 04:07:43
-- Versión del servidor: 10.1.28-MariaDB
-- Versión de PHP: 7.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `prueba`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `ID_negocios` int(11) NOT NULL,
  `comentario` longtext NOT NULL,
  `fecha` date NOT NULL,
  `persona` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `giro_negocios`
--

CREATE TABLE `giro_negocios` (
  `ID_giro` int(11) NOT NULL,
  `Giro` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `giro_negocios`
--

INSERT INTO `giro_negocios` (`ID_giro`, `Giro`) VALUES
(1, 'Farmacia'),
(2, 'Papelería'),
(3, 'Supermercado'),
(4, 'Tienda de fotografía'),
(5, 'Lavandería'),
(6, 'Restaurante'),
(7, 'Tintorería'),
(8, 'Autolavado '),
(9, 'Taller Mecánico'),
(10, 'Fábrica de dulces'),
(11, 'Mueblería'),
(12, 'Fábrica de frituras'),
(13, 'Fundidoras'),
(14, 'Cafetería'),
(15, 'Industria cultural y creativa'),
(16, 'Tecnologías de la Información'),
(17, 'Educación extra escolar'),
(18, 'Energías renovables'),
(19, 'Arreglo de ropa y calzado'),
(20, 'Turismo'),
(21, 'Turismo'),
(22, 'Pesca'),
(23, 'Bienes raíces'),
(24, 'Construcción'),
(25, 'Ganadería'),
(26, 'Transporte aéreo'),
(27, 'Software'),
(28, 'Telecomunicaciones'),
(29, 'Metalurgia'),
(30, 'Cinematográfica'),
(31, 'Editorial'),
(32, 'Mercados mayoristas'),
(33, 'Productores agrícolas'),
(34, 'Electricidad'),
(35, 'Empresa de diseño'),
(36, 'Agua potable'),
(37, 'Cobranzas'),
(38, 'Vigilancia'),
(39, 'Derecho');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial`
--

CREATE TABLE `historial` (
  `ID_historial` int(11) NOT NULL,
  `ID_usuarios` int(11) NOT NULL,
  `inicio_sesion` varchar(20) NOT NULL,
  `final_sesion` varchar(20) NOT NULL,
  `fecha` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `historial`
--

INSERT INTO `historial` (`ID_historial`, `ID_usuarios`, `inicio_sesion`, `final_sesion`, `fecha`) VALUES
(1, 1, 'null', 'null', 'null'),
(2, 1, 'dsf', 'sdf', 'sdf');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `negocios`
--

CREATE TABLE `negocios` (
  `ID_negocios` int(11) NOT NULL,
  `ID_usuarios` int(11) NOT NULL,
  `Nombre_negocios` varchar(100) DEFAULT NULL,
  `Giro_negocios` int(10) NOT NULL,
  `Telefono_negocios` varchar(10) NOT NULL,
  `CP_negocios` int(11) NOT NULL,
  `NumExt_negocios` varchar(10) NOT NULL,
  `NumInt_negocios` varchar(10) NOT NULL,
  `HrLunesDs_negocios` varchar(10) NOT NULL,
  `HrLunesHs_negocios` varchar(10) NOT NULL,
  `HrSabadoDs_negocios` varchar(10) DEFAULT NULL,
  `HrSabadoHs_negocios` varchar(10) DEFAULT NULL,
  `HrDomingoDs_negocios` varchar(10) DEFAULT NULL,
  `HrDomingoHs_negocios` varchar(10) DEFAULT NULL,
  `Coordenadas_negocios` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `negocios`
--

INSERT INTO `negocios` (`ID_negocios`, `ID_usuarios`, `Nombre_negocios`, `Giro_negocios`, `Telefono_negocios`, `CP_negocios`, `NumExt_negocios`, `NumInt_negocios`, `HrLunesDs_negocios`, `HrLunesHs_negocios`, `HrSabadoDs_negocios`, `HrSabadoHs_negocios`, `HrDomingoDs_negocios`, `HrDomingoHs_negocios`, `Coordenadas_negocios`) VALUES
(22, 8, 'Farmacio del ahorro', 1, '248487698', 74020, '17', '', '09:00', '22:00', '10:00', '22:00', '10:00', '22:00', '19.2893917,-98.44058749999999');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `ID_productos` int(11) NOT NULL,
  `ID_negocios` int(11) NOT NULL,
  `Nombre_productos` varchar(100) NOT NULL,
  `Descripcion_productos` longtext NOT NULL,
  `Precio_Productos` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promociones`
--

CREATE TABLE `promociones` (
  `ID_promociones` int(11) NOT NULL,
  `ID_negocios` int(11) NOT NULL,
  `promocion` varchar(500) NOT NULL,
  `VigenciaIni_promociones` varchar(50) NOT NULL,
  `VigenciaFin_promociones` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `ID_usuarios` int(11) NOT NULL,
  `Rol_usuarios` varchar(13) NOT NULL,
  `Nombre_usuarios` varchar(30) NOT NULL,
  `ApellidoPa_usuarios` varchar(30) NOT NULL,
  `ApellidoMa_usuarios` varchar(30) NOT NULL,
  `Telefono_usuarios` varchar(10) NOT NULL,
  `Correo_usuarios` varchar(50) NOT NULL,
  `Contrasena_usuarios` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`ID_usuarios`, `Rol_usuarios`, `Nombre_usuarios`, `ApellidoPa_usuarios`, `ApellidoMa_usuarios`, `Telefono_usuarios`, `Correo_usuarios`, `Contrasena_usuarios`) VALUES
(1, 'Administrador', 'Alejandro', 'Richaud', 'Renteria', '2481429077', 'a.richaud@hotmail.es', '3738336136'),
(8, 'Gerente', 'Pablo', 'Lopez', 'Rene', '2481429865', 'p.lopez@hotmail.com', '3738336136');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valoraciones`
--

CREATE TABLE `valoraciones` (
  `ID_negocios` int(11) NOT NULL,
  `pulgares_abajo` int(11) NOT NULL,
  `pulgares_arriba` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD KEY `ID_negocios` (`ID_negocios`);

--
-- Indices de la tabla `giro_negocios`
--
ALTER TABLE `giro_negocios`
  ADD PRIMARY KEY (`ID_giro`);

--
-- Indices de la tabla `historial`
--
ALTER TABLE `historial`
  ADD PRIMARY KEY (`ID_historial`),
  ADD KEY `ID_usuarios` (`ID_usuarios`);

--
-- Indices de la tabla `negocios`
--
ALTER TABLE `negocios`
  ADD PRIMARY KEY (`ID_negocios`),
  ADD KEY `ID_usuarios` (`ID_usuarios`),
  ADD KEY `Giro_negocios` (`Giro_negocios`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`ID_productos`),
  ADD KEY `productos_ibfk_1` (`ID_negocios`);

--
-- Indices de la tabla `promociones`
--
ALTER TABLE `promociones`
  ADD PRIMARY KEY (`ID_promociones`),
  ADD KEY `promociones_ibfk_1` (`ID_negocios`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`ID_usuarios`);

--
-- Indices de la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  ADD KEY `ID_negocios` (`ID_negocios`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `giro_negocios`
--
ALTER TABLE `giro_negocios`
  MODIFY `ID_giro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `historial`
--
ALTER TABLE `historial`
  MODIFY `ID_historial` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `negocios`
--
ALTER TABLE `negocios`
  MODIFY `ID_negocios` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `ID_productos` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `promociones`
--
ALTER TABLE `promociones`
  MODIFY `ID_promociones` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `ID_usuarios` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`ID_negocios`) REFERENCES `negocios` (`ID_negocios`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `historial`
--
ALTER TABLE `historial`
  ADD CONSTRAINT `historial_ibfk_1` FOREIGN KEY (`ID_usuarios`) REFERENCES `usuarios` (`ID_usuarios`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `negocios`
--
ALTER TABLE `negocios`
  ADD CONSTRAINT `negocios_ibfk_1` FOREIGN KEY (`ID_usuarios`) REFERENCES `usuarios` (`ID_usuarios`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `negocios_ibfk_2` FOREIGN KEY (`Giro_negocios`) REFERENCES `giro_negocios` (`ID_giro`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`ID_negocios`) REFERENCES `negocios` (`ID_negocios`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `promociones`
--
ALTER TABLE `promociones`
  ADD CONSTRAINT `promociones_ibfk_1` FOREIGN KEY (`ID_negocios`) REFERENCES `negocios` (`ID_negocios`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  ADD CONSTRAINT `valoraciones_ibfk_1` FOREIGN KEY (`ID_negocios`) REFERENCES `negocios` (`ID_negocios`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
