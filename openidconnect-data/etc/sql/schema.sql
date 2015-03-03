-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.6.19-0ubuntu0.14.04.1


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema OpenIDConnect
--

--CREATE DATABASE IF NOT EXISTS OpenIDConnect;
USE openidconnecttest;

--
-- Definition of table `access_token`
--

DROP TABLE IF EXISTS `access_token`;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `access_token`
--

/*!40000 ALTER TABLE `access_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `access_token` ENABLE KEYS */;


--
-- Definition of table `address`
--

DROP TABLE IF EXISTS `address`;
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

--
-- Dumping data for table `address`
--

/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;


--
-- Definition of table `approved_site`
--

DROP TABLE IF EXISTS `approved_site`;
CREATE TABLE `approved_site` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(4096) DEFAULT NULL,
  `client_id` varchar(4096) DEFAULT NULL,
  `creation_date` timestamp NULL DEFAULT NULL,
  `access_date` timestamp NULL DEFAULT NULL,
  `timeout_date` timestamp NULL DEFAULT NULL,
  `whitelisted_site_id` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `approved_site`
--

/*!40000 ALTER TABLE `approved_site` DISABLE KEYS */;
/*!40000 ALTER TABLE `approved_site` ENABLE KEYS */;


--
-- Definition of table `approved_site_scope`
--

DROP TABLE IF EXISTS `approved_site_scope`;
CREATE TABLE `approved_site_scope` (
  `owner_id` bigint(20) DEFAULT NULL,
  `scope` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `approved_site_scope`
--

/*!40000 ALTER TABLE `approved_site_scope` DISABLE KEYS */;
/*!40000 ALTER TABLE `approved_site_scope` ENABLE KEYS */;


--
-- Definition of table `authentication_holder`
--

DROP TABLE IF EXISTS `authentication_holder`;
CREATE TABLE `authentication_holder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `owner_id` bigint(20) DEFAULT NULL,
  `authentication` longblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `authentication_holder`
--

/*!40000 ALTER TABLE `authentication_holder` DISABLE KEYS */;
/*!40000 ALTER TABLE `authentication_holder` ENABLE KEYS */;


--
-- Definition of table `authorization_code`
--

DROP TABLE IF EXISTS `authorization_code`;
CREATE TABLE `authorization_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(256) DEFAULT NULL,
  `authentication` longblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `authorization_code`
--

/*!40000 ALTER TABLE `authorization_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `authorization_code` ENABLE KEYS */;


--
-- Definition of table `blacklisted_site`
--

DROP TABLE IF EXISTS `blacklisted_site`;
CREATE TABLE `blacklisted_site` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uri` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `blacklisted_site`
--

/*!40000 ALTER TABLE `blacklisted_site` DISABLE KEYS */;
/*!40000 ALTER TABLE `blacklisted_site` ENABLE KEYS */;


--
-- Definition of table `client_authority`
--

DROP TABLE IF EXISTS `client_authority`;
CREATE TABLE `client_authority` (
  `owner_id` bigint(20) DEFAULT NULL,
  `authority` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client_authority`
--

/*!40000 ALTER TABLE `client_authority` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_authority` ENABLE KEYS */;


--
-- Definition of table `client_contact`
--

DROP TABLE IF EXISTS `client_contact`;
CREATE TABLE `client_contact` (
  `owner_id` bigint(20) DEFAULT NULL,
  `contact` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client_contact`
--

/*!40000 ALTER TABLE `client_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_contact` ENABLE KEYS */;


--
-- Definition of table `client_default_acr_value`
--

DROP TABLE IF EXISTS `client_default_acr_value`;
CREATE TABLE `client_default_acr_value` (
  `owner_id` bigint(20) DEFAULT NULL,
  `default_acr_value` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client_default_acr_value`
--

/*!40000 ALTER TABLE `client_default_acr_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_default_acr_value` ENABLE KEYS */;


--
-- Definition of table `client_details`
--

DROP TABLE IF EXISTS `client_details`;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client_details`
--

/*!40000 ALTER TABLE `client_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_details` ENABLE KEYS */;


--
-- Definition of table `client_grant_type`
--

DROP TABLE IF EXISTS `client_grant_type`;
CREATE TABLE `client_grant_type` (
  `owner_id` bigint(20) DEFAULT NULL,
  `grant_type` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client_grant_type`
--

/*!40000 ALTER TABLE `client_grant_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_grant_type` ENABLE KEYS */;


--
-- Definition of table `client_redirect_uri`
--

DROP TABLE IF EXISTS `client_redirect_uri`;
CREATE TABLE `client_redirect_uri` (
  `owner_id` bigint(20) DEFAULT NULL,
  `redirect_uri` varchar(2048) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client_redirect_uri`
--

/*!40000 ALTER TABLE `client_redirect_uri` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_redirect_uri` ENABLE KEYS */;


--
-- Definition of table `client_request_uri`
--

DROP TABLE IF EXISTS `client_request_uri`;
CREATE TABLE `client_request_uri` (
  `owner_id` bigint(20) DEFAULT NULL,
  `request_uri` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client_request_uri`
--

/*!40000 ALTER TABLE `client_request_uri` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_request_uri` ENABLE KEYS */;


--
-- Definition of table `client_resource`
--

DROP TABLE IF EXISTS `client_resource`;
CREATE TABLE `client_resource` (
  `owner_id` bigint(20) DEFAULT NULL,
  `resource_id` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client_resource`
--

/*!40000 ALTER TABLE `client_resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_resource` ENABLE KEYS */;


--
-- Definition of table `client_response_type`
--

DROP TABLE IF EXISTS `client_response_type`;
CREATE TABLE `client_response_type` (
  `owner_id` bigint(20) DEFAULT NULL,
  `response_type` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client_response_type`
--

/*!40000 ALTER TABLE `client_response_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_response_type` ENABLE KEYS */;


--
-- Definition of table `client_scope`
--

DROP TABLE IF EXISTS `client_scope`;
CREATE TABLE `client_scope` (
  `owner_id` bigint(20) DEFAULT NULL,
  `scope` varchar(2048) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client_scope`
--

/*!40000 ALTER TABLE `client_scope` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_scope` ENABLE KEYS */;


--
-- Definition of table `pairwise_identifier`
--

DROP TABLE IF EXISTS `pairwise_identifier`;
CREATE TABLE `pairwise_identifier` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(256) DEFAULT NULL,
  `sub` varchar(256) DEFAULT NULL,
  `sector_identifier` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pairwise_identifier`
--

/*!40000 ALTER TABLE `pairwise_identifier` DISABLE KEYS */;
/*!40000 ALTER TABLE `pairwise_identifier` ENABLE KEYS */;


--
-- Definition of table `refresh_token`
--

DROP TABLE IF EXISTS `refresh_token`;
CREATE TABLE `refresh_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token_value` varchar(4096) DEFAULT NULL,
  `expiration` timestamp NULL DEFAULT NULL,
  `auth_holder_id` bigint(20) DEFAULT NULL,
  `client_id` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `refresh_token`
--

/*!40000 ALTER TABLE `refresh_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `refresh_token` ENABLE KEYS */;


--
-- Definition of table `system_scope`
--

DROP TABLE IF EXISTS `system_scope`;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `system_scope`
--

/*!40000 ALTER TABLE `system_scope` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_scope` ENABLE KEYS */;


--
-- Definition of table `token_scope`
--

DROP TABLE IF EXISTS `token_scope`;
CREATE TABLE `token_scope` (
  `owner_id` bigint(20) DEFAULT NULL,
  `scope` varchar(2048) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `token_scope`
--

/*!40000 ALTER TABLE `token_scope` DISABLE KEYS */;
/*!40000 ALTER TABLE `token_scope` ENABLE KEYS */;


--
-- Definition of table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_info`
--

/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;


--
-- Definition of table `whitelisted_site`
--

DROP TABLE IF EXISTS `whitelisted_site`;
CREATE TABLE `whitelisted_site` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creator_user_id` varchar(256) DEFAULT NULL,
  `client_id` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `whitelisted_site`
--

/*!40000 ALTER TABLE `whitelisted_site` DISABLE KEYS */;
/*!40000 ALTER TABLE `whitelisted_site` ENABLE KEYS */;


--
-- Definition of table `whitelisted_site_scope`
--

DROP TABLE IF EXISTS `whitelisted_site_scope`;
CREATE TABLE `whitelisted_site_scope` (
  `owner_id` bigint(20) DEFAULT NULL,
  `scope` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `whitelisted_site_scope`
--

/*!40000 ALTER TABLE `whitelisted_site_scope` DISABLE KEYS */;
/*!40000 ALTER TABLE `whitelisted_site_scope` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
