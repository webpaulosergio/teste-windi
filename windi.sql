/*
Navicat MySQL Data Transfer

Source Server         : Local
Source Server Version : 50724
Source Host           : 127.0.0.1:3306
Source Database       : windi

Target Server Type    : MYSQL
Target Server Version : 50724
File Encoding         : 65001

Date: 2019-03-29 02:16:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for opcoes
-- ----------------------------
DROP TABLE IF EXISTS `opcoes`;
CREATE TABLE `opcoes` (
  `id_interno` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(20) DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_interno`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of opcoes
-- ----------------------------
INSERT INTO `opcoes` VALUES ('1', 'modelo', 'Uno');
INSERT INTO `opcoes` VALUES ('2', 'modelo', 'Palio');
INSERT INTO `opcoes` VALUES ('3', 'modelo', 'Siena');
INSERT INTO `opcoes` VALUES ('4', 'modelo', 'Polo');
INSERT INTO `opcoes` VALUES ('5', 'modelo', 'Saveiro ');
INSERT INTO `opcoes` VALUES ('6', 'modelo', 'Voyage');
INSERT INTO `opcoes` VALUES ('7', 'modelo', 'Fox');
INSERT INTO `opcoes` VALUES ('8', 'modelo', 'Logan');
INSERT INTO `opcoes` VALUES ('9', 'modelo', 'Duster ');
INSERT INTO `opcoes` VALUES ('10', 'modelo', 'HB20');
INSERT INTO `opcoes` VALUES ('11', 'modelo', 'Tucson ');
INSERT INTO `opcoes` VALUES ('12', 'modelo', 'Corolla ');
INSERT INTO `opcoes` VALUES ('13', 'modelo', 'Etios ');
INSERT INTO `opcoes` VALUES ('14', 'modelo', 'Civic');
INSERT INTO `opcoes` VALUES ('15', 'opcionais', 'Faróis de LED');
INSERT INTO `opcoes` VALUES ('16', 'opcionais', 'Central Multimídia');
INSERT INTO `opcoes` VALUES ('17', 'opcionais', 'Alarme');
INSERT INTO `opcoes` VALUES ('18', 'opcionais', 'Trava Elétrica');
INSERT INTO `opcoes` VALUES ('19', 'opcionais', 'Ar-Condicionado');
INSERT INTO `opcoes` VALUES ('20', 'opcionais', 'Filtro de ar esportivo');
INSERT INTO `opcoes` VALUES ('21', 'opcionais', 'Calha de chuva');
INSERT INTO `opcoes` VALUES ('22', 'opcionais', 'Suporte para bicicletas');
INSERT INTO `opcoes` VALUES ('23', 'opcionais', 'Rodas Esportivas');

-- ----------------------------
-- Table structure for veiculos
-- ----------------------------
DROP TABLE IF EXISTS `veiculos`;
CREATE TABLE `veiculos` (
  `id_interno` int(11) NOT NULL AUTO_INCREMENT,
  `modelo` int(11) DEFAULT NULL,
  `placa` varchar(255) DEFAULT NULL,
  `renavam` varchar(255) DEFAULT NULL,
  `valor_venda` decimal(25,2) DEFAULT NULL,
  `data_cadastro` datetime DEFAULT NULL,
  PRIMARY KEY (`id_interno`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of veiculos
-- ----------------------------
INSERT INTO `veiculos` VALUES ('1', '1', 'abc-1234', '12345678900', '15550.00', '2019-03-29 02:03:15');
INSERT INTO `veiculos` VALUES ('2', '10', 'DEF-5678', '987654321', '32145.00', '2019-03-29 02:03:15');

-- ----------------------------
-- Table structure for veiculo_opcionais
-- ----------------------------
DROP TABLE IF EXISTS `veiculo_opcionais`;
CREATE TABLE `veiculo_opcionais` (
  `id_interno` int(11) NOT NULL AUTO_INCREMENT,
  `id_veiculo` int(11) DEFAULT NULL,
  `id_opcao` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_interno`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of veiculo_opcionais
-- ----------------------------
INSERT INTO `veiculo_opcionais` VALUES ('1', '1', '16');
INSERT INTO `veiculo_opcionais` VALUES ('2', '1', '17');
INSERT INTO `veiculo_opcionais` VALUES ('3', '1', '18');
INSERT INTO `veiculo_opcionais` VALUES ('4', '1', '19');
INSERT INTO `veiculo_opcionais` VALUES ('5', '2', '15');
INSERT INTO `veiculo_opcionais` VALUES ('6', '2', '16');
INSERT INTO `veiculo_opcionais` VALUES ('7', '2', '17');
INSERT INTO `veiculo_opcionais` VALUES ('8', '2', '18');
INSERT INTO `veiculo_opcionais` VALUES ('9', '2', '19');
INSERT INTO `veiculo_opcionais` VALUES ('10', '2', '21');
