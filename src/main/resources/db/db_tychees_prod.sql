-- phpMyAdmin SQL Dump
-- version 4.6.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 29, 2019 at 07:06 AM
-- Server version: 5.7.14-google-log
-- PHP Version: 5.5.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_tychees_prod`
--

-- --------------------------------------------------------

--
-- Table structure for table `batch_request_table`
--

CREATE TABLE `batch_request_table` (
  `id` varchar(45) NOT NULL,
  `place_id` varchar(45) DEFAULT NULL,
  `user_id` varchar(45) NOT NULL,
  `action_id` varchar(45) NOT NULL,
  `action_name` varchar(180) DEFAULT NULL,
  `action_desc` varchar(90) DEFAULT NULL,
  `action_status` varchar(45) DEFAULT NULL,
  `action_status_desc` varchar(90) DEFAULT NULL,
  `started_on` timestamp NULL DEFAULT NULL,
  `ended_on` timestamp NULL DEFAULT NULL,
  `file_name` varchar(90) DEFAULT NULL,
  `base64` mediumtext,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(45) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(45) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `billing_bucket_line_table`
--

CREATE TABLE `billing_bucket_line_table` (
  `id` varchar(90) NOT NULL,
  `bucket_id` varchar(90) NOT NULL,
  `billing_id` varchar(90) DEFAULT NULL,
  `billing_no` varchar(90) DEFAULT NULL,
  `billing_line_id` varchar(90) DEFAULT NULL,
  `parent_line_id` varchar(90) DEFAULT NULL,
  `component_id` varchar(90) DEFAULT NULL,
  `item_id` varchar(90) DEFAULT NULL,
  `item_name` varchar(90) DEFAULT NULL,
  `item_type` varchar(90) DEFAULT NULL,
  `item_group_name` varchar(90) DEFAULT NULL,
  `item_labels` varchar(360) DEFAULT NULL,
  `item_image_url` varchar(360) DEFAULT NULL,
  `row_id` varchar(90) DEFAULT NULL,
  `selected` tinyint(1) DEFAULT NULL,
  `ignored` tinyint(1) DEFAULT '0',
  `mandatory` tinyint(1) DEFAULT '0',
  `quantity` double DEFAULT '0',
  `quantity_optional` tinyint(1) DEFAULT '0',
  `item_unit_price` double DEFAULT NULL,
  `billable_amount` double DEFAULT NULL,
  `unit_price_source` varchar(45) DEFAULT NULL,
  `default_unit_price` double DEFAULT NULL,
  `compound_unit_price` double DEFAULT NULL,
  `custom_unit_price` double DEFAULT '0',
  `compound_unit_cost` double DEFAULT NULL,
  `tax_inclusive` tinyint(1) DEFAULT NULL,
  `tax_discount_in_percentage` tinyint(1) DEFAULT NULL,
  `tax_discount_in_amount` tinyint(1) DEFAULT NULL,
  `tax_amount` double DEFAULT '0',
  `tax_percentage` double DEFAULT '0',
  `discount_amount` double DEFAULT '0',
  `discount_percentage` double DEFAULT '0',
  `add_to_billing` tinyint(1) DEFAULT '0',
  `remarks` varchar(180) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `billing_bucket_table`
--

CREATE TABLE `billing_bucket_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) NOT NULL,
  `layout_component_id` varchar(90) DEFAULT NULL,
  `bucket_name` varchar(90) DEFAULT NULL,
  `bucket_status` varchar(45) DEFAULT NULL,
  `pax_count` int(11) DEFAULT NULL,
  `pax_max_count` int(11) DEFAULT NULL,
  `seated_on` timestamp NULL DEFAULT NULL,
  `ordered_on` timestamp NULL DEFAULT NULL,
  `completed_on` timestamp NULL DEFAULT NULL,
  `left_on` timestamp NULL DEFAULT NULL,
  `served_by` varchar(90) DEFAULT NULL,
  `customer_no` varchar(90) DEFAULT NULL,
  `customer_name` varchar(180) DEFAULT NULL,
  `customer_contact` varchar(45) DEFAULT NULL,
  `reserved_on` timestamp NULL DEFAULT NULL,
  `reserved_from` timestamp NULL DEFAULT NULL,
  `reserved_to` timestamp NULL DEFAULT NULL,
  `cancelled_by` varchar(90) DEFAULT NULL,
  `cancelled_on` timestamp NULL DEFAULT NULL,
  `remarks` varchar(180) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `billing_delivery_table`
--

CREATE TABLE `billing_delivery_table` (
  `id` varchar(90) NOT NULL,
  `billing_id` varchar(90) NOT NULL,
  `ref_no` varchar(45) DEFAULT NULL,
  `contact_no` varchar(45) DEFAULT NULL,
  `received_on` timestamp NULL DEFAULT NULL,
  `dispatched_on` timestamp NULL DEFAULT NULL,
  `terms` varchar(90) DEFAULT NULL,
  `method` varchar(45) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `attention_to` varchar(45) DEFAULT NULL,
  `street_line_1` varchar(90) DEFAULT NULL,
  `street_line_2` varchar(90) DEFAULT NULL,
  `street_line_3` varchar(90) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `area` varchar(90) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `default_address` tinyint(1) NOT NULL DEFAULT '0',
  `longitude` double DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `altitude` double DEFAULT NULL,
  `accuracy` double DEFAULT NULL,
  `remarks` varchar(180) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `billing_line_table`
--

CREATE TABLE `billing_line_table` (
  `id` varchar(90) NOT NULL,
  `billing_id` varchar(90) NOT NULL,
  `parent_line_id` varchar(90) DEFAULT NULL,
  `component_id` varchar(90) DEFAULT NULL,
  `item_id` varchar(90) DEFAULT NULL,
  `item_name` varchar(90) DEFAULT NULL,
  `item_type` varchar(90) DEFAULT NULL,
  `item_group_name` varchar(90) DEFAULT NULL,
  `item_image_url` varchar(360) DEFAULT NULL,
  `row_id` varchar(90) DEFAULT NULL,
  `seqno` int(11) DEFAULT '0',
  `selected` tinyint(1) DEFAULT NULL,
  `ignored` tinyint(1) DEFAULT '0',
  `mandatory` tinyint(1) DEFAULT '0',
  `quantity` double DEFAULT '0',
  `quantity_optional` tinyint(1) DEFAULT '0',
  `item_unit_price` double DEFAULT NULL,
  `billable_amount` double DEFAULT NULL,
  `unit_price_source` varchar(45) DEFAULT NULL,
  `default_unit_price` double DEFAULT NULL,
  `compound_unit_price` double DEFAULT NULL,
  `custom_unit_price` double DEFAULT '0',
  `compound_unit_cost` double DEFAULT NULL,
  `tax_inclusive` tinyint(1) DEFAULT NULL,
  `tax_discount_in_percentage` tinyint(1) DEFAULT NULL,
  `tax_discount_in_amount` tinyint(1) DEFAULT NULL,
  `tax_amount` double DEFAULT '0',
  `tax_percentage` double DEFAULT '0',
  `discount_amount` double DEFAULT '0',
  `discount_percentage` double DEFAULT '0',
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `billing_payment_properties_table`
--

CREATE TABLE `billing_payment_properties_table` (
  `id` varchar(90) NOT NULL,
  `payment_id` varchar(90) DEFAULT NULL,
  `group_name` varchar(180) DEFAULT NULL,
  `prop_seqno` int(11) DEFAULT NULL,
  `prop_key` varchar(90) DEFAULT NULL,
  `prop_name` varchar(90) DEFAULT NULL,
  `prop_type` varchar(20) DEFAULT NULL,
  `prop_content` varchar(180) DEFAULT NULL,
  `prop_value` varchar(516) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `billing_payment_table`
--

CREATE TABLE `billing_payment_table` (
  `id` varchar(90) NOT NULL,
  `billing_id` varchar(90) NOT NULL,
  `place_id` varchar(45) DEFAULT NULL,
  `payment_date` timestamp NULL DEFAULT NULL,
  `paying_amount` double DEFAULT NULL,
  `change_amount` double DEFAULT NULL,
  `method` varchar(90) DEFAULT NULL,
  `method_desc` varchar(90) DEFAULT NULL,
  `details` varchar(180) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `billing_properties_table`
--

CREATE TABLE `billing_properties_table` (
  `id` varchar(90) NOT NULL,
  `billing_id` varchar(90) NOT NULL,
  `group_name` varchar(180) DEFAULT NULL,
  `prop_seqno` int(11) DEFAULT NULL,
  `prop_key` varchar(90) DEFAULT NULL,
  `prop_name` varchar(90) DEFAULT NULL,
  `prop_type` varchar(20) DEFAULT NULL,
  `prop_content` varchar(180) DEFAULT NULL,
  `prop_value` varchar(516) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `billing_table`
--

CREATE TABLE `billing_table` (
  `id` varchar(90) NOT NULL,
  `bucket_id` varchar(90) DEFAULT NULL,
  `billing_no` varchar(45) DEFAULT NULL,
  `billing_date` timestamp NULL DEFAULT NULL,
  `place_id` varchar(90) NOT NULL,
  `customer_id` varchar(90) DEFAULT NULL,
  `customer_name` varchar(180) DEFAULT NULL,
  `employee_id` varchar(90) DEFAULT NULL,
  `employee_name` varchar(180) DEFAULT NULL,
  `transaction_id` varchar(90) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `state_desc` varchar(90) DEFAULT NULL,
  `tax_amount` double DEFAULT '0',
  `tax_percentage` double DEFAULT '0',
  `discount_amount` double DEFAULT '0',
  `discount_percentage` double DEFAULT '0',
  `sub_total_amount` double DEFAULT '0',
  `total_amount` double DEFAULT '0',
  `round_off_amount` double DEFAULT '0',
  `total_payment` double DEFAULT '0',
  `payment_terms` varchar(90) DEFAULT NULL,
  `purchase_order_no` varchar(45) DEFAULT NULL,
  `purchase_order_date` timestamp NULL DEFAULT NULL,
  `invoice_no` varchar(45) DEFAULT NULL,
  `invoice_date` timestamp NULL DEFAULT NULL,
  `receipt_no` varchar(45) DEFAULT NULL,
  `receipt_date` timestamp NULL DEFAULT NULL,
  `quotation_no` varchar(90) DEFAULT NULL,
  `quotation_date` timestamp NULL DEFAULT NULL,
  `attributes` varchar(360) DEFAULT NULL,
  `remarks` varchar(180) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `billing_workflow_event_table`
--

CREATE TABLE `billing_workflow_event_table` (
  `id` varchar(90) NOT NULL,
  `workflow_id` varchar(90) NOT NULL,
  `seqno` int(11) DEFAULT NULL,
  `event_key` varchar(45) DEFAULT NULL,
  `event_title` varchar(90) DEFAULT NULL,
  `event_description` varchar(360) DEFAULT NULL,
  `tracked_on` timestamp NULL DEFAULT NULL,
  `tracked_by` varchar(90) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `billing_workflow_table`
--

CREATE TABLE `billing_workflow_table` (
  `id` varchar(90) NOT NULL,
  `billing_id` varchar(90) NOT NULL,
  `module_id` varchar(90) DEFAULT NULL,
  `sub_module_id` varchar(90) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `common_calendar_event_table`
--

CREATE TABLE `common_calendar_event_table` (
  `id` varchar(90) NOT NULL,
  `calendar_id` varchar(90) DEFAULT NULL,
  `title` varchar(180) DEFAULT NULL,
  `all_day` tinyint(1) DEFAULT NULL,
  `start` timestamp NULL DEFAULT NULL,
  `end` timestamp NULL DEFAULT NULL,
  `url` varchar(360) DEFAULT NULL,
  `editable` tinyint(1) DEFAULT NULL,
  `start_editable` tinyint(1) DEFAULT NULL,
  `duration_editable` tinyint(1) DEFAULT NULL,
  `resource_editable` tinyint(1) DEFAULT NULL,
  `overlap` tinyint(1) DEFAULT NULL,
  `color` varchar(10) DEFAULT NULL,
  `background_color` varchar(10) DEFAULT NULL,
  `border_color` varchar(10) DEFAULT NULL,
  `text_color` varchar(10) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `common_calendar_table`
--

CREATE TABLE `common_calendar_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) NOT NULL,
  `user_id` varchar(90) DEFAULT NULL,
  `foreign_id` varchar(90) DEFAULT NULL,
  `calendar_name` varchar(180) DEFAULT NULL,
  `view_name` varchar(90) DEFAULT NULL,
  `color` varchar(10) DEFAULT NULL,
  `background_color` varchar(10) DEFAULT NULL,
  `border_color` varchar(10) DEFAULT NULL,
  `text_color` varchar(10) DEFAULT NULL,
  `showing` tinyint(1) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `common_template_properties_table`
--

CREATE TABLE `common_template_properties_table` (
  `id` varchar(90) NOT NULL,
  `template_id` varchar(90) DEFAULT NULL,
  `group_name` varchar(180) DEFAULT NULL,
  `prop_seqno` int(11) DEFAULT NULL,
  `prop_key` varchar(90) DEFAULT NULL,
  `prop_name` varchar(90) DEFAULT NULL,
  `prop_type` varchar(20) DEFAULT NULL,
  `prop_content` varchar(180) DEFAULT NULL,
  `prop_value` varchar(516) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `common_template_table`
--

CREATE TABLE `common_template_table` (
  `id` varchar(90) NOT NULL,
  `parent_id` varchar(90) NOT NULL,
  `module_id` varchar(90) DEFAULT NULL,
  `template_type` varchar(90) DEFAULT NULL,
  `template_name` varchar(180) DEFAULT NULL,
  `default_template` tinyint(1) DEFAULT '0',
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_address_table`
--

CREATE TABLE `customer_address_table` (
  `id` varchar(90) NOT NULL,
  `customer_id` varchar(90) NOT NULL,
  `default_address` tinyint(1) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `attention_to` varchar(45) DEFAULT NULL,
  `street_line_1` varchar(90) DEFAULT NULL,
  `street_line_2` varchar(90) DEFAULT NULL,
  `street_line_3` varchar(90) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `area` varchar(90) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `altitude` double DEFAULT NULL,
  `accuracy` double DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_contact_table`
--

CREATE TABLE `customer_contact_table` (
  `id` varchar(90) NOT NULL,
  `customer_id` varchar(90) NOT NULL,
  `default_contact` tinyint(1) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `country_code` varchar(5) DEFAULT NULL,
  `area_code` varchar(5) NOT NULL,
  `phone_number` varchar(45) NOT NULL,
  `extension` varchar(20) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_email_table`
--

CREATE TABLE `customer_email_table` (
  `id` varchar(90) NOT NULL,
  `customer_id` varchar(90) NOT NULL,
  `type` varchar(90) DEFAULT NULL,
  `default_email` tinyint(1) DEFAULT NULL,
  `email_address` varchar(180) NOT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_profile_properties_table`
--

CREATE TABLE `customer_profile_properties_table` (
  `id` varchar(90) NOT NULL,
  `profile_id` varchar(90) DEFAULT NULL,
  `group_name` varchar(180) DEFAULT NULL,
  `prop_seqno` int(11) DEFAULT NULL,
  `prop_key` varchar(90) DEFAULT NULL,
  `prop_name` varchar(90) DEFAULT NULL,
  `prop_type` varchar(20) DEFAULT NULL,
  `prop_content` varchar(180) DEFAULT NULL,
  `prop_value` varchar(516) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_profile_table`
--

CREATE TABLE `customer_profile_table` (
  `id` varchar(90) NOT NULL,
  `customer_id` varchar(90) NOT NULL,
  `profile_name` varchar(180) DEFAULT NULL,
  `default_profile` tinyint(1) DEFAULT '0',
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_properties_table`
--

CREATE TABLE `customer_properties_table` (
  `id` varchar(90) NOT NULL,
  `customer_id` varchar(90) NOT NULL,
  `group_name` varchar(180) DEFAULT NULL,
  `prop_seqno` int(11) DEFAULT NULL,
  `prop_key` varchar(90) DEFAULT NULL,
  `prop_name` varchar(90) DEFAULT NULL,
  `prop_type` varchar(20) DEFAULT NULL,
  `prop_content` varchar(180) DEFAULT NULL,
  `prop_value` varchar(516) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_table`
--

CREATE TABLE `customer_table` (
  `id` varchar(90) NOT NULL,
  `user_id` varchar(90) NOT NULL,
  `place_id` varchar(90) NOT NULL,
  `customer_no` varchar(90) DEFAULT NULL,
  `template_id` varchar(90) DEFAULT NULL,
  `template_name` varchar(180) DEFAULT NULL,
  `last_billing_id` varchar(90) DEFAULT NULL,
  `last_billing_no` varchar(90) DEFAULT NULL,
  `employee_id` varchar(90) DEFAULT NULL,
  `employee_name` varchar(180) DEFAULT NULL,
  `first_name` varchar(90) NOT NULL,
  `last_name` varchar(90) NOT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `contact` varchar(45) DEFAULT NULL,
  `email` varchar(180) DEFAULT NULL,
  `address` varchar(360) DEFAULT NULL,
  `area` varchar(90) DEFAULT NULL,
  `profile_image_url` varchar(255) DEFAULT NULL,
  `description` varchar(180) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `department_job_table`
--

CREATE TABLE `department_job_table` (
  `id` varchar(90) NOT NULL,
  `department_id` varchar(90) DEFAULT NULL,
  `job_id` varchar(90) DEFAULT NULL,
  `min_salary` double DEFAULT NULL,
  `max_salary` double DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `department_table`
--

CREATE TABLE `department_table` (
  `id` varchar(90) NOT NULL,
  `name` varchar(180) DEFAULT NULL,
  `manager_id` varchar(90) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `document_properties_table`
--

CREATE TABLE `document_properties_table` (
  `id` varchar(90) NOT NULL,
  `document_id` varchar(90) NOT NULL,
  `editable` tinyint(1) DEFAULT '0',
  `require_input_from_user` tinyint(1) DEFAULT '0',
  `group_name` varchar(180) DEFAULT NULL,
  `prop_seqno` int(11) DEFAULT NULL,
  `prop_key` varchar(90) DEFAULT NULL,
  `prop_name` varchar(90) DEFAULT NULL,
  `prop_type` varchar(20) DEFAULT NULL,
  `prop_content` varchar(180) DEFAULT NULL,
  `prop_value` varchar(4096) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `document_table`
--

CREATE TABLE `document_table` (
  `id` varchar(90) NOT NULL,
  `module_id` varchar(45) DEFAULT NULL,
  `doc_name` varchar(90) DEFAULT NULL,
  `doc_code` varchar(45) DEFAULT NULL,
  `doc_type` varchar(45) DEFAULT NULL,
  `doc_type_name` varchar(90) DEFAULT NULL,
  `doc_url` varchar(255) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `employee_address_table`
--

CREATE TABLE `employee_address_table` (
  `id` varchar(90) NOT NULL,
  `employee_id` varchar(90) NOT NULL,
  `default_address` tinyint(1) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `attention_to` varchar(45) DEFAULT NULL,
  `street_line_1` varchar(90) DEFAULT NULL,
  `street_line_2` varchar(90) DEFAULT NULL,
  `street_line_3` varchar(90) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `area` varchar(90) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `altitude` double DEFAULT NULL,
  `accuracy` double DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `employee_contact_table`
--

CREATE TABLE `employee_contact_table` (
  `id` varchar(90) NOT NULL,
  `employee_id` varchar(90) NOT NULL,
  `default_contact` tinyint(1) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `country_code` varchar(5) DEFAULT NULL,
  `area_code` varchar(5) NOT NULL,
  `phone_number` varchar(45) NOT NULL,
  `extension` varchar(20) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `employee_email_table`
--

CREATE TABLE `employee_email_table` (
  `id` varchar(90) NOT NULL,
  `employee_id` varchar(90) NOT NULL,
  `type` varchar(90) DEFAULT NULL,
  `default_email` tinyint(1) DEFAULT NULL,
  `email_address` varchar(180) NOT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `employee_job_table`
--

CREATE TABLE `employee_job_table` (
  `id` varchar(90) NOT NULL,
  `employee_id` varchar(90) NOT NULL,
  `job_id` varchar(90) DEFAULT NULL,
  `department_id` varchar(90) DEFAULT NULL,
  `start_on` timestamp NULL DEFAULT NULL,
  `end_on` timestamp NULL DEFAULT NULL,
  `present_job` tinyint(1) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `employee_properties_table`
--

CREATE TABLE `employee_properties_table` (
  `id` varchar(90) NOT NULL,
  `employee_id` varchar(90) NOT NULL,
  `group_name` varchar(180) DEFAULT NULL,
  `prop_seqno` int(11) DEFAULT NULL,
  `prop_key` varchar(90) DEFAULT NULL,
  `prop_name` varchar(90) DEFAULT NULL,
  `prop_type` varchar(20) DEFAULT NULL,
  `prop_content` varchar(180) DEFAULT NULL,
  `prop_value` varchar(516) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `employee_table`
--

CREATE TABLE `employee_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) DEFAULT NULL,
  `employee_no` varchar(90) DEFAULT NULL,
  `template_id` varchar(90) DEFAULT NULL,
  `template_name` varchar(180) DEFAULT NULL,
  `department_id` varchar(90) DEFAULT NULL,
  `hired_on` timestamp NULL DEFAULT NULL,
  `terminated_on` timestamp NULL DEFAULT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `contact` varchar(45) DEFAULT NULL,
  `email` varchar(180) DEFAULT NULL,
  `address` varchar(360) DEFAULT NULL,
  `area` varchar(90) DEFAULT NULL,
  `profile_image_url` varchar(255) DEFAULT NULL,
  `description` varchar(180) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `index_master_table`
--

CREATE TABLE `index_master_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) DEFAULT NULL,
  `bean_id` varchar(90) DEFAULT NULL,
  `last_indexed_on` timestamp NULL DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `index_term_table`
--

CREATE TABLE `index_term_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) DEFAULT NULL,
  `bean_id` varchar(90) DEFAULT NULL,
  `bean_class_name` varchar(360) DEFAULT NULL,
  `bean_display_name` varchar(360) DEFAULT NULL,
  `term` varchar(45) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `position` varchar(180) DEFAULT NULL,
  `synopsys` varchar(1024) DEFAULT NULL,
  `view_bean` varchar(1024) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_category_properties_table`
--

CREATE TABLE `inventory_category_properties_table` (
  `id` varchar(90) NOT NULL,
  `category_id` varchar(90) NOT NULL,
  `seqno` int(11) DEFAULT NULL,
  `inherited_category_id` varchar(90) DEFAULT NULL,
  `inherited` tinyint(1) DEFAULT NULL,
  `required` tinyint(1) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT NULL,
  `group_name` varchar(180) DEFAULT NULL,
  `prop_seqno` int(11) DEFAULT NULL,
  `prop_key` varchar(90) DEFAULT NULL,
  `prop_name` varchar(90) DEFAULT NULL,
  `prop_type` varchar(20) DEFAULT NULL,
  `prop_content` varchar(180) DEFAULT NULL,
  `prop_value` varchar(516) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_category_table`
--

CREATE TABLE `inventory_category_table` (
  `id` varchar(90) NOT NULL,
  `business_type_id` varchar(90) DEFAULT NULL,
  `parent_category_id` varchar(90) DEFAULT NULL,
  `parent_category_name` varchar(180) DEFAULT NULL,
  `place_id` varchar(90) DEFAULT NULL,
  `item_type` varchar(45) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `seqno` int(11) DEFAULT NULL,
  `system_defined` tinyint(1) DEFAULT '0',
  `pos_visible` tinyint(1) DEFAULT '0',
  `scm_visible` tinyint(1) DEFAULT NULL,
  `remarks` varchar(11) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_item_component_table`
--

CREATE TABLE `inventory_item_component_table` (
  `id` varchar(90) NOT NULL,
  `item_id` varchar(90) DEFAULT NULL,
  `seqno` int(11) DEFAULT NULL,
  `category_id` varchar(90) DEFAULT NULL,
  `item_group_list` varchar(360) DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL,
  `help_text` varchar(90) DEFAULT NULL,
  `group_name` varchar(45) DEFAULT NULL,
  `seqno_in_group` int(11) DEFAULT NULL,
  `selection_mode` varchar(45) DEFAULT NULL,
  `selectable` tinyint(1) DEFAULT NULL,
  `minimum_selection` int(11) DEFAULT NULL,
  `maximum_selection` int(11) DEFAULT NULL,
  `allow_default_quantity_only` tinyint(1) DEFAULT NULL,
  `default_quantity` double DEFAULT NULL,
  `tags` varchar(360) DEFAULT NULL,
  `item_ids` varchar(360) DEFAULT NULL,
  `exclude_item_ids` varchar(1024) DEFAULT NULL,
  `default_item_ids` varchar(1024) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_item_image_table`
--

CREATE TABLE `inventory_item_image_table` (
  `id` varchar(90) NOT NULL COMMENT 'Unique ID for inventory photo. ',
  `item_id` varchar(90) DEFAULT NULL COMMENT 'Reference ID to inventory_table',
  `name` varchar(180) DEFAULT NULL COMMENT 'Name of photo',
  `url` varchar(255) DEFAULT NULL COMMENT 'URL path of photo',
  `type` varchar(30) DEFAULT NULL COMMENT 'Type of photo',
  `alt_text` varchar(180) DEFAULT NULL COMMENT 'Alternate text when image is hover',
  `long_desc` varchar(360) DEFAULT NULL COMMENT 'Caption text that descript this image.',
  `width` int(11) DEFAULT NULL COMMENT 'Width in pixel',
  `height` int(11) DEFAULT NULL COMMENT 'Height in pixel',
  `base64` mediumtext,
  `file_name` varchar(90) DEFAULT NULL,
  `file_type` varchar(90) DEFAULT NULL,
  `file_extension` varchar(45) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `seqno` int(11) DEFAULT '0',
  `pws_visible` tinyint(1) DEFAULT '0',
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_item_properties_table`
--

CREATE TABLE `inventory_item_properties_table` (
  `id` varchar(90) NOT NULL,
  `item_id` varchar(90) NOT NULL,
  `category_properties_id` varchar(90) NOT NULL,
  `seqno` int(11) DEFAULT NULL,
  `required` tinyint(1) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT NULL,
  `group_name` varchar(180) DEFAULT NULL,
  `prop_seqno` int(11) DEFAULT NULL,
  `prop_key` varchar(90) DEFAULT NULL,
  `prop_name` varchar(90) DEFAULT NULL,
  `prop_type` varchar(20) DEFAULT NULL,
  `prop_content` varchar(180) DEFAULT NULL,
  `prop_value` varchar(516) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_item_rule_table`
--

CREATE TABLE `inventory_item_rule_table` (
  `id` varchar(90) NOT NULL COMMENT 'Unique ID for inventory label.',
  `item_id` varchar(90) NOT NULL COMMENT 'Reference ID to inventory_table',
  `name` varchar(90) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_item_table`
--

CREATE TABLE `inventory_item_table` (
  `id` varchar(90) NOT NULL COMMENT 'Unique ID for Inventory Item',
  `category_id` varchar(90) NOT NULL,
  `category_name` varchar(180) DEFAULT NULL,
  `place_id` varchar(90) NOT NULL COMMENT 'Reference ID to place_table',
  `group_name` varchar(90) NOT NULL,
  `name` varchar(90) DEFAULT NULL,
  `sku_code` varchar(90) DEFAULT NULL,
  `item_type` varchar(45) DEFAULT NULL,
  `seqno_in_group` int(11) DEFAULT '0',
  `labels` varchar(360) DEFAULT NULL,
  `availability` varchar(45) DEFAULT NULL,
  `pos_visible` tinyint(1) DEFAULT '0',
  `pws_visible` tinyint(1) DEFAULT '0',
  `scm_visible` tinyint(1) DEFAULT '0',
  `image_url` varchar(360) DEFAULT NULL,
  `measurement_unit` varchar(45) DEFAULT NULL,
  `quantity_optional` tinyint(1) DEFAULT NULL,
  `minimum_quantity` double DEFAULT NULL,
  `quantity` double DEFAULT NULL,
  `unit_cost` double DEFAULT NULL,
  `unit_price` double DEFAULT NULL,
  `tax_inclusive` tinyint(1) DEFAULT NULL,
  `tax_discount_in_percentage` tinyint(1) DEFAULT NULL,
  `tax_discount_in_amount` tinyint(1) DEFAULT NULL,
  `tax_discount_percentage` double DEFAULT NULL,
  `tax_discount_amount` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `altitude` double DEFAULT '0',
  `accuracy` double DEFAULT '0',
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'First creation date/time.',
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL COMMENT 'Last update date/time.',
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_item_transaction_table`
--

CREATE TABLE `inventory_item_transaction_table` (
  `id` varchar(90) NOT NULL,
  `item_id` varchar(90) DEFAULT NULL,
  `billing_id` varchar(90) DEFAULT NULL,
  `billing_line_id` varchar(90) DEFAULT NULL,
  `operator` varchar(45) DEFAULT NULL,
  `quantity` double DEFAULT NULL,
  `reason` varchar(180) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_transaction_line_table`
--

CREATE TABLE `inventory_transaction_line_table` (
  `id` varchar(90) NOT NULL,
  `transaction_id` varchar(90) DEFAULT NULL,
  `item_id` varchar(90) DEFAULT NULL,
  `foreign_item_id` varchar(90) DEFAULT NULL,
  `description` varchar(180) DEFAULT NULL,
  `operator` varchar(45) DEFAULT NULL,
  `quantity` double DEFAULT NULL,
  `unit_price` double DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_transaction_table`
--

CREATE TABLE `inventory_transaction_table` (
  `id` varchar(90) NOT NULL COMMENT 'Unique ID for Inventory Item',
  `place_id` varchar(90) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `third_party_id` varchar(90) DEFAULT NULL,
  `third_party_type` varchar(45) DEFAULT NULL,
  `sub_total_amount` double DEFAULT NULL,
  `tax_amount` double DEFAULT NULL,
  `discount_amount` double DEFAULT NULL,
  `total_amount` double DEFAULT NULL,
  `executed` tinyint(1) DEFAULT NULL,
  `approved_on` timestamp NULL DEFAULT NULL,
  `approved_by` varchar(90) DEFAULT NULL,
  `delivered_on` timestamp NULL DEFAULT NULL,
  `delivered_by` varchar(90) DEFAULT NULL,
  `received_on` timestamp NULL DEFAULT NULL,
  `received_by` varchar(90) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'First creation date/time.',
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL COMMENT 'Last update date/time.',
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_access_properties_table`
--

CREATE TABLE `place_access_properties_table` (
  `id` varchar(90) NOT NULL,
  `access_id` varchar(90) DEFAULT NULL,
  `group_name` varchar(180) DEFAULT NULL,
  `prop_seqno` int(11) DEFAULT NULL,
  `prop_key` varchar(90) DEFAULT NULL,
  `prop_name` varchar(90) DEFAULT NULL,
  `prop_type` varchar(20) DEFAULT NULL,
  `prop_content` varchar(180) DEFAULT NULL,
  `prop_value` varchar(516) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_access_table`
--

CREATE TABLE `place_access_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) DEFAULT NULL,
  `role_name` varchar(90) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) NOT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) NOT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_address_table`
--

CREATE TABLE `place_address_table` (
  `id` varchar(45) NOT NULL,
  `place_id` varchar(45) NOT NULL,
  `default_address` tinyint(1) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `attention_to` varchar(45) DEFAULT NULL,
  `street_line_1` varchar(90) DEFAULT NULL,
  `street_line_2` varchar(90) DEFAULT NULL,
  `street_line_3` varchar(90) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `area` varchar(90) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `longitude` double DEFAULT '0',
  `latitude` double DEFAULT '0',
  `altitude` double DEFAULT '0',
  `accuracy` double DEFAULT '0',
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(45) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(45) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_contact_table`
--

CREATE TABLE `place_contact_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) NOT NULL,
  `default_contact` tinyint(1) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `country_code` varchar(5) DEFAULT NULL,
  `area_code` varchar(5) NOT NULL,
  `phone_number` varchar(16) NOT NULL,
  `extension` varchar(20) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_document_properties_table`
--

CREATE TABLE `place_document_properties_table` (
  `id` varchar(90) NOT NULL,
  `place_document_id` varchar(90) DEFAULT NULL,
  `document_id` varchar(90) NOT NULL,
  `editable` tinyint(1) DEFAULT '0',
  `require_input_from_script` tinyint(1) DEFAULT '0',
  `require_input_from_user` tinyint(1) DEFAULT '0',
  `user_input` varchar(1024) DEFAULT NULL,
  `group_name` varchar(180) DEFAULT NULL,
  `prop_seqno` int(11) DEFAULT NULL,
  `prop_key` varchar(90) DEFAULT NULL,
  `prop_name` varchar(90) DEFAULT NULL,
  `prop_type` varchar(20) DEFAULT NULL,
  `prop_content` varchar(180) DEFAULT NULL,
  `prop_value` varchar(4096) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_document_table`
--

CREATE TABLE `place_document_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) DEFAULT NULL,
  `document_id` varchar(90) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_document_template_component_table`
--

CREATE TABLE `place_document_template_component_table` (
  `id` varchar(90) NOT NULL,
  `place_document_template_id` varchar(90) DEFAULT NULL,
  `name` varchar(90) DEFAULT NULL,
  `object_type` varchar(45) DEFAULT NULL,
  `seqno` int(11) DEFAULT '0',
  `attributes` varchar(2000) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) NOT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) NOT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_document_template_table`
--

CREATE TABLE `place_document_template_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) DEFAULT NULL,
  `name` varchar(90) DEFAULT NULL,
  `template_type` varchar(90) DEFAULT NULL,
  `page_type` varchar(45) DEFAULT NULL,
  `width` int(11) DEFAULT '0',
  `height` int(11) DEFAULT '0',
  `available` tinyint(1) DEFAULT '0',
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_image_table`
--

CREATE TABLE `place_image_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) DEFAULT NULL,
  `name` varchar(180) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `alt_text` varchar(180) DEFAULT NULL,
  `long_desc` varchar(360) DEFAULT NULL,
  `width` int(11) DEFAULT NULL COMMENT 'Width in pixel',
  `height` int(11) DEFAULT NULL COMMENT 'Height in pixel',
  `base64` mediumtext,
  `file_name` varchar(90) DEFAULT NULL,
  `file_type` varchar(90) DEFAULT NULL,
  `file_extension` varchar(45) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `seqno` int(11) DEFAULT '0',
  `type_logo` tinyint(1) NOT NULL DEFAULT '0',
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) NOT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) NOT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_label_table`
--

CREATE TABLE `place_label_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) DEFAULT NULL,
  `keyword` varchar(90) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `relevance` double DEFAULT NULL,
  `labels` varchar(360) DEFAULT NULL,
  `searchable` tinyint(1) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `altitude` double DEFAULT NULL,
  `accuracy` double DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) NOT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) NOT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_layout_component_table`
--

CREATE TABLE `place_layout_component_table` (
  `id` varchar(90) NOT NULL,
  `layout_id` varchar(90) DEFAULT NULL,
  `bucket_id` varchar(90) DEFAULT NULL,
  `name` varchar(90) DEFAULT NULL,
  `pax_count` int(11) DEFAULT '0',
  `object_type` varchar(45) DEFAULT NULL,
  `fill_style` varchar(45) DEFAULT NULL,
  `stroke_style` varchar(45) DEFAULT NULL,
  `shadow_color` varchar(45) DEFAULT NULL,
  `shadow_blur` varchar(45) DEFAULT NULL,
  `shadow_offset_x` varchar(45) DEFAULT NULL,
  `shadow_offset_y` varchar(45) DEFAULT NULL,
  `attributes` varchar(360) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) NOT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) NOT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_layout_table`
--

CREATE TABLE `place_layout_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) DEFAULT NULL,
  `layout_name` varchar(90) DEFAULT NULL,
  `default_layout` tinyint(1) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) NOT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) NOT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_module_table`
--

CREATE TABLE `place_module_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) DEFAULT NULL,
  `module_id` varchar(90) DEFAULT NULL,
  `module_layout_id` varchar(45) DEFAULT NULL,
  `module_layout_path` varchar(180) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_notification_table`
--

CREATE TABLE `place_notification_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) DEFAULT NULL,
  `user_id` varchar(90) DEFAULT NULL,
  `request_id` varchar(45) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `description` varchar(360) DEFAULT NULL,
  `notification_read` tinyint(1) DEFAULT '0',
  `notification_read_on` timestamp NULL DEFAULT NULL,
  `download_available` tinyint(1) NOT NULL DEFAULT '0',
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_operating_hour_table`
--

CREATE TABLE `place_operating_hour_table` (
  `id` varchar(45) NOT NULL,
  `place_id` varchar(45) DEFAULT NULL,
  `showing` tinyint(1) DEFAULT NULL,
  `open_time_day` int(11) DEFAULT NULL,
  `open_time_hour` int(11) DEFAULT NULL,
  `open_time_minute` int(11) DEFAULT NULL,
  `close_time_day` int(11) DEFAULT NULL,
  `close_time_hour` int(11) DEFAULT NULL,
  `close_time_minute` int(11) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(45) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(45) NOT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(45) NOT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_properties_table`
--

CREATE TABLE `place_properties_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) DEFAULT NULL,
  `group_name` varchar(180) DEFAULT NULL,
  `prop_seqno` int(11) DEFAULT NULL,
  `prop_key` varchar(90) DEFAULT NULL,
  `prop_name` varchar(90) DEFAULT NULL,
  `prop_type` varchar(20) DEFAULT NULL,
  `prop_content` varchar(180) DEFAULT NULL,
  `prop_value` varchar(516) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_role_table`
--

CREATE TABLE `place_role_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) DEFAULT NULL,
  `user_id` varchar(90) DEFAULT NULL,
  `role` varchar(45) DEFAULT NULL,
  `designation` varchar(180) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) NOT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) NOT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_settings_table`
--

CREATE TABLE `place_settings_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) DEFAULT NULL,
  `module_id` varchar(90) DEFAULT NULL,
  `sub_module_id` varchar(90) DEFAULT NULL,
  `group_name` varchar(180) DEFAULT NULL,
  `prop_seqno` int(11) DEFAULT NULL,
  `prop_key` varchar(90) DEFAULT NULL,
  `prop_name` varchar(90) DEFAULT NULL,
  `prop_type` varchar(90) DEFAULT NULL,
  `prop_content` varchar(516) DEFAULT NULL,
  `prop_value` varchar(516) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_table`
--

CREATE TABLE `place_table` (
  `id` varchar(90) NOT NULL,
  `longitude` double DEFAULT '0',
  `latitude` double DEFAULT '0',
  `altitude` double DEFAULT '0',
  `accuracy` double DEFAULT '0',
  `name` varchar(90) DEFAULT NULL,
  `company_name` varchar(180) DEFAULT NULL,
  `company_registration_no` varchar(90) DEFAULT NULL,
  `category` varchar(180) DEFAULT NULL,
  `subcategory` varchar(360) DEFAULT NULL,
  `labels` varchar(180) DEFAULT NULL,
  `description` varchar(360) DEFAULT NULL,
  `address` varchar(360) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `mobile` varchar(90) DEFAULT NULL,
  `website` varchar(360) DEFAULT NULL,
  `email` varchar(256) NOT NULL,
  `logo_image_url` varchar(360) DEFAULT NULL,
  `logo_image_width` int(11) DEFAULT NULL,
  `logo_image_height` int(11) DEFAULT NULL,
  `price_range` varchar(45) DEFAULT NULL,
  `rating` double DEFAULT '0',
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) NOT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) NOT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_workflow_event_table`
--

CREATE TABLE `place_workflow_event_table` (
  `id` varchar(90) NOT NULL,
  `workflow_id` varchar(90) NOT NULL,
  `seqno` int(11) DEFAULT NULL,
  `event_key` varchar(90) DEFAULT NULL,
  `event_title` varchar(90) DEFAULT NULL,
  `event_description` varchar(360) DEFAULT NULL,
  `tracked_on` timestamp NULL DEFAULT NULL,
  `tracked_by` varchar(90) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `place_workflow_table`
--

CREATE TABLE `place_workflow_table` (
  `id` varchar(90) NOT NULL,
  `place_id` varchar(90) NOT NULL,
  `module_id` varchar(90) DEFAULT NULL,
  `sub_module_id` varchar(90) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_access_right_table`
--

CREATE TABLE `user_access_right_table` (
  `id` varchar(45) NOT NULL,
  `user_id` varchar(45) NOT NULL,
  `place_id` varchar(90) DEFAULT NULL,
  `function_id` varchar(90) DEFAULT NULL,
  `readable` tinyint(1) DEFAULT '0',
  `writable` tinyint(1) DEFAULT '0',
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(45) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(45) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_action_table`
--

CREATE TABLE `user_action_table` (
  `id` varchar(45) NOT NULL,
  `user_id` varchar(45) NOT NULL,
  `action_bean_id` varchar(45) NOT NULL,
  `action_bean_name` varchar(180) DEFAULT NULL,
  `action_type` varchar(45) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(45) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(45) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_properties_table`
--

CREATE TABLE `user_properties_table` (
  `id` varchar(90) NOT NULL,
  `user_id` varchar(90) DEFAULT NULL,
  `group_name` varchar(180) DEFAULT NULL,
  `prop_seqno` int(11) DEFAULT NULL,
  `prop_key` varchar(90) DEFAULT NULL,
  `prop_name` varchar(90) DEFAULT NULL,
  `prop_type` varchar(20) DEFAULT NULL,
  `prop_content` varchar(180) DEFAULT NULL,
  `prop_value` varchar(516) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_role_table`
--

CREATE TABLE `user_role_table` (
  `id` varchar(45) NOT NULL,
  `user_id` varchar(45) NOT NULL,
  `place_id` varchar(90) NOT NULL,
  `role_name` varchar(90) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(45) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(45) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_security_table`
--

CREATE TABLE `user_security_table` (
  `id` varchar(90) NOT NULL,
  `password` varchar(1024) DEFAULT NULL,
  `c_salt` varchar(512) DEFAULT NULL,
  `s_salt` varchar(512) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_session_table`
--

CREATE TABLE `user_session_table` (
  `id` varchar(90) NOT NULL,
  `user_id` varchar(90) NOT NULL,
  `email` varchar(90) NOT NULL,
  `remember` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `remote_address` varchar(180) DEFAULT NULL,
  `user_agent` varchar(180) DEFAULT NULL,
  `sso_provider` varchar(90) DEFAULT NULL,
  `started_on` timestamp NULL DEFAULT NULL,
  `last_accessed_on` timestamp NULL DEFAULT NULL,
  `ended_on` timestamp NULL DEFAULT NULL,
  `validity_period` bigint(20) DEFAULT NULL,
  `readable_started_on` varchar(90) DEFAULT NULL,
  `readable_last_accessed_on` varchar(90) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_table`
--

CREATE TABLE `user_table` (
  `id` varchar(90) NOT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `home_radius` double DEFAULT '0',
  `home_longitude` double DEFAULT '0',
  `home_latitude` double DEFAULT '0',
  `reset_password_required` tinyint(1) NOT NULL DEFAULT '0',
  `logout_required` tinyint(1) NOT NULL DEFAULT '0',
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `contact` varchar(45) DEFAULT NULL,
  `email` varchar(180) DEFAULT NULL,
  `address` varchar(360) DEFAULT NULL,
  `area` varchar(90) DEFAULT NULL,
  `profile_image_url` varchar(255) DEFAULT NULL,
  `description` varchar(180) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL,
  `created_by` varchar(90) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(90) DEFAULT NULL,
  `deleted_on` timestamp NULL DEFAULT NULL,
  `deleted_by` varchar(90) DEFAULT NULL,
  `jdoDetachedState` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `batch_request_table`
--
ALTER TABLE `batch_request_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billing_bucket_line_table`
--
ALTER TABLE `billing_bucket_line_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billing_bucket_table`
--
ALTER TABLE `billing_bucket_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billing_delivery_table`
--
ALTER TABLE `billing_delivery_table`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fkey` (`billing_id`);

--
-- Indexes for table `billing_line_table`
--
ALTER TABLE `billing_line_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billing_payment_properties_table`
--
ALTER TABLE `billing_payment_properties_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billing_payment_table`
--
ALTER TABLE `billing_payment_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billing_properties_table`
--
ALTER TABLE `billing_properties_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billing_table`
--
ALTER TABLE `billing_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billing_workflow_event_table`
--
ALTER TABLE `billing_workflow_event_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billing_workflow_table`
--
ALTER TABLE `billing_workflow_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `common_calendar_event_table`
--
ALTER TABLE `common_calendar_event_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `common_calendar_table`
--
ALTER TABLE `common_calendar_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `common_template_properties_table`
--
ALTER TABLE `common_template_properties_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `common_template_table`
--
ALTER TABLE `common_template_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_address_table`
--
ALTER TABLE `customer_address_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_contact_table`
--
ALTER TABLE `customer_contact_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_email_table`
--
ALTER TABLE `customer_email_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_profile_properties_table`
--
ALTER TABLE `customer_profile_properties_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_profile_table`
--
ALTER TABLE `customer_profile_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_properties_table`
--
ALTER TABLE `customer_properties_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_table`
--
ALTER TABLE `customer_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `department_job_table`
--
ALTER TABLE `department_job_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `department_table`
--
ALTER TABLE `department_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `document_properties_table`
--
ALTER TABLE `document_properties_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `document_table`
--
ALTER TABLE `document_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_address_table`
--
ALTER TABLE `employee_address_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_contact_table`
--
ALTER TABLE `employee_contact_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_email_table`
--
ALTER TABLE `employee_email_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_job_table`
--
ALTER TABLE `employee_job_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_properties_table`
--
ALTER TABLE `employee_properties_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_table`
--
ALTER TABLE `employee_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `index_master_table`
--
ALTER TABLE `index_master_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `index_term_table`
--
ALTER TABLE `index_term_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory_category_properties_table`
--
ALTER TABLE `inventory_category_properties_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory_category_table`
--
ALTER TABLE `inventory_category_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory_item_component_table`
--
ALTER TABLE `inventory_item_component_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory_item_image_table`
--
ALTER TABLE `inventory_item_image_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory_item_properties_table`
--
ALTER TABLE `inventory_item_properties_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory_item_rule_table`
--
ALTER TABLE `inventory_item_rule_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory_item_table`
--
ALTER TABLE `inventory_item_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory_item_transaction_table`
--
ALTER TABLE `inventory_item_transaction_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory_transaction_line_table`
--
ALTER TABLE `inventory_transaction_line_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory_transaction_table`
--
ALTER TABLE `inventory_transaction_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_access_properties_table`
--
ALTER TABLE `place_access_properties_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_access_table`
--
ALTER TABLE `place_access_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_address_table`
--
ALTER TABLE `place_address_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_contact_table`
--
ALTER TABLE `place_contact_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_document_properties_table`
--
ALTER TABLE `place_document_properties_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_document_table`
--
ALTER TABLE `place_document_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_document_template_component_table`
--
ALTER TABLE `place_document_template_component_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_document_template_table`
--
ALTER TABLE `place_document_template_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_image_table`
--
ALTER TABLE `place_image_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_label_table`
--
ALTER TABLE `place_label_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_layout_component_table`
--
ALTER TABLE `place_layout_component_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_layout_table`
--
ALTER TABLE `place_layout_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_module_table`
--
ALTER TABLE `place_module_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_notification_table`
--
ALTER TABLE `place_notification_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_operating_hour_table`
--
ALTER TABLE `place_operating_hour_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_properties_table`
--
ALTER TABLE `place_properties_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_role_table`
--
ALTER TABLE `place_role_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_settings_table`
--
ALTER TABLE `place_settings_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_table`
--
ALTER TABLE `place_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_workflow_event_table`
--
ALTER TABLE `place_workflow_event_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `place_workflow_table`
--
ALTER TABLE `place_workflow_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_access_right_table`
--
ALTER TABLE `user_access_right_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_action_table`
--
ALTER TABLE `user_action_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_properties_table`
--
ALTER TABLE `user_properties_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_role_table`
--
ALTER TABLE `user_role_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_security_table`
--
ALTER TABLE `user_security_table`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `user_session_table`
--
ALTER TABLE `user_session_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_table`
--
ALTER TABLE `user_table`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
