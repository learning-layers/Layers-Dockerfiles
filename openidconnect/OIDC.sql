CREATE DATABASE  IF NOT EXISTS `OpenIDConnect` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `OpenIDConnect`;
-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: 137.226.232.222    Database: OpenIDConnect
-- ------------------------------------------------------
-- Server version	5.5.43-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `access_token`
--

DROP TABLE IF EXISTS `access_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token_value` varchar(4096) DEFAULT NULL,
  `expiration` timestamp NULL DEFAULT NULL,
  `token_type` varchar(256) DEFAULT NULL,
  `refresh_token_id` bigint(20) DEFAULT NULL,
  `client_id` varchar(256) DEFAULT NULL,
  `auth_holder_id` bigint(20) DEFAULT NULL,
  `id_token_id` bigint(20) DEFAULT NULL,
  `approved_site_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12615 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `formatted` varchar(256) DEFAULT NULL,
  `street_address` varchar(256) DEFAULT NULL,
  `locality` varchar(256) DEFAULT NULL,
  `region` varchar(256) DEFAULT NULL,
  `postal_code` varchar(256) DEFAULT NULL,
  `country` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `approved_site`
--

DROP TABLE IF EXISTS `approved_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `approved_site` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(4096) DEFAULT NULL,
  `client_id` varchar(4096) DEFAULT NULL,
  `creation_date` timestamp NULL DEFAULT NULL,
  `access_date` timestamp NULL DEFAULT NULL,
  `timeout_date` timestamp NULL DEFAULT NULL,
  `whitelisted_site_id` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=698 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `approved_site_scope`
--

DROP TABLE IF EXISTS `approved_site_scope`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `approved_site_scope` (
  `owner_id` bigint(20) DEFAULT NULL,
  `scope` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authentication_holder`
--

DROP TABLE IF EXISTS `authentication_holder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authentication_holder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `owner_id` bigint(20) DEFAULT NULL,
  `authentication` longblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6324 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authorities`
--

DROP TABLE IF EXISTS `authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorities` (
  `username` varchar(50) NOT NULL,
  `authority` varchar(50) NOT NULL,
  UNIQUE KEY `ix_authority` (`username`,`authority`),
  CONSTRAINT `fk_authorities_users` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authorization_code`
--

DROP TABLE IF EXISTS `authorization_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorization_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(256) DEFAULT NULL,
  `authentication` longblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2742 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blacklisted_site`
--

DROP TABLE IF EXISTS `blacklisted_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blacklisted_site` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uri` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_authority`
--

DROP TABLE IF EXISTS `client_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_authority` (
  `owner_id` bigint(20) DEFAULT NULL,
  `authority` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_contact`
--

DROP TABLE IF EXISTS `client_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_contact` (
  `owner_id` bigint(20) DEFAULT NULL,
  `contact` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_default_acr_value`
--

DROP TABLE IF EXISTS `client_default_acr_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_default_acr_value` (
  `owner_id` bigint(20) DEFAULT NULL,
  `default_acr_value` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_details`
--

DROP TABLE IF EXISTS `client_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_description` varchar(1024) DEFAULT NULL,
  `reuse_refresh_tokens` tinyint(1) NOT NULL DEFAULT '1',
  `dynamically_registered` tinyint(1) NOT NULL DEFAULT '0',
  `allow_introspection` tinyint(1) NOT NULL DEFAULT '0',
  `id_token_validity_seconds` bigint(20) NOT NULL DEFAULT '600',
  `client_id` varchar(256) DEFAULT NULL,
  `client_secret` varchar(2048) DEFAULT NULL,
  `access_token_validity_seconds` bigint(20) DEFAULT NULL,
  `refresh_token_validity_seconds` bigint(20) DEFAULT NULL,
  `application_type` varchar(256) DEFAULT NULL,
  `client_name` varchar(256) DEFAULT NULL,
  `token_endpoint_auth_method` varchar(256) DEFAULT NULL,
  `subject_type` varchar(256) DEFAULT NULL,
  `logo_uri` varchar(2048) DEFAULT NULL,
  `policy_uri` varchar(2048) DEFAULT NULL,
  `client_uri` varchar(2048) DEFAULT NULL,
  `tos_uri` varchar(2048) DEFAULT NULL,
  `jwks_uri` varchar(2048) DEFAULT NULL,
  `sector_identifier_uri` varchar(2048) DEFAULT NULL,
  `request_object_signing_alg` varchar(256) DEFAULT NULL,
  `user_info_signed_response_alg` varchar(256) DEFAULT NULL,
  `user_info_encrypted_response_alg` varchar(256) DEFAULT NULL,
  `user_info_encrypted_response_enc` varchar(256) DEFAULT NULL,
  `id_token_signed_response_alg` varchar(256) DEFAULT NULL,
  `id_token_encrypted_response_alg` varchar(256) DEFAULT NULL,
  `id_token_encrypted_response_enc` varchar(256) DEFAULT NULL,
  `token_endpoint_auth_signing_alg` varchar(256) DEFAULT NULL,
  `default_max_age` bigint(20) DEFAULT NULL,
  `require_auth_time` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `initiate_login_uri` varchar(2048) DEFAULT NULL,
  `post_logout_redirect_uri` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_grant_type`
--

DROP TABLE IF EXISTS `client_grant_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_grant_type` (
  `owner_id` bigint(20) DEFAULT NULL,
  `grant_type` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_redirect_uri`
--

DROP TABLE IF EXISTS `client_redirect_uri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_redirect_uri` (
  `owner_id` bigint(20) DEFAULT NULL,
  `redirect_uri` varchar(2048) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_request_uri`
--

DROP TABLE IF EXISTS `client_request_uri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_request_uri` (
  `owner_id` bigint(20) DEFAULT NULL,
  `request_uri` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_resource`
--

DROP TABLE IF EXISTS `client_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_resource` (
  `owner_id` bigint(20) DEFAULT NULL,
  `resource_id` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_response_type`
--

DROP TABLE IF EXISTS `client_response_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_response_type` (
  `owner_id` bigint(20) DEFAULT NULL,
  `response_type` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_scope`
--

DROP TABLE IF EXISTS `client_scope`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_scope` (
  `owner_id` bigint(20) DEFAULT NULL,
  `scope` varchar(2048) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pairwise_identifier`
--

DROP TABLE IF EXISTS `pairwise_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pairwise_identifier` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(256) DEFAULT NULL,
  `sub` varchar(256) DEFAULT NULL,
  `sector_identifier` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `refresh_token`
--

DROP TABLE IF EXISTS `refresh_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `refresh_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token_value` varchar(4096) DEFAULT NULL,
  `expiration` timestamp NULL DEFAULT NULL,
  `auth_holder_id` bigint(20) DEFAULT NULL,
  `client_id` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=451 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `system_scope`
--

DROP TABLE IF EXISTS `system_scope`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_scope` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `scope` varchar(256) NOT NULL,
  `description` varchar(4096) DEFAULT NULL,
  `icon` varchar(256) DEFAULT NULL,
  `allow_dyn_reg` tinyint(1) NOT NULL DEFAULT '0',
  `default_scope` tinyint(1) NOT NULL DEFAULT '0',
  `structured` tinyint(1) NOT NULL DEFAULT '0',
  `structured_param_description` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `scope` (`scope`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `token_scope`
--

DROP TABLE IF EXISTS `token_scope`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token_scope` (
  `owner_id` bigint(20) DEFAULT NULL,
  `scope` varchar(2048) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sub` varchar(256) DEFAULT NULL,
  `preferred_username` varchar(256) DEFAULT NULL,
  `name` varchar(256) DEFAULT NULL,
  `given_name` varchar(256) DEFAULT NULL,
  `family_name` varchar(256) DEFAULT NULL,
  `middle_name` varchar(256) DEFAULT NULL,
  `nickname` varchar(256) DEFAULT NULL,
  `profile` varchar(256) DEFAULT NULL,
  `picture` varchar(256) DEFAULT NULL,
  `website` varchar(256) DEFAULT NULL,
  `email` varchar(256) DEFAULT NULL,
  `email_verified` tinyint(1) DEFAULT NULL,
  `gender` varchar(256) DEFAULT NULL,
  `zone_info` varchar(256) DEFAULT NULL,
  `locale` varchar(256) DEFAULT NULL,
  `phone_number` varchar(256) DEFAULT NULL,
  `phone_number_verified` tinyint(1) DEFAULT NULL,
  `address_id` varchar(256) DEFAULT NULL,
  `updated_time` varchar(256) DEFAULT NULL,
  `birthdate` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `whitelisted_site`
--

DROP TABLE IF EXISTS `whitelisted_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `whitelisted_site` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creator_user_id` varchar(256) DEFAULT NULL,
  `client_id` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `whitelisted_site_scope`
--

DROP TABLE IF EXISTS `whitelisted_site_scope`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `whitelisted_site_scope` (
  `owner_id` bigint(20) DEFAULT NULL,
  `scope` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'OpenIDConnect'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

