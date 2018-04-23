CREATE TABLE `tmp_historie_uzivatelu` (
  `tmp_historie_uzivatelu_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` varchar(16) DEFAULT NULL,
  `z30_barcode` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_due` datetime DEFAULT NULL,
  `branchcode` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `returndate` datetime DEFAULT NULL,
  `lastreneweddate` datetime DEFAULT NULL,
  `renewals` tinyint(4) DEFAULT NULL,
  `auto_renew` tinyint(1) DEFAULT '0',
  `auto_renew_error` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `issuedate` datetime DEFAULT NULL,
  `onsite_checkout` int(1) NOT NULL DEFAULT '0',
  `note` mediumtext COLLATE utf8_unicode_ci,
  `notedate` datetime DEFAULT NULL,
  PRIMARY KEY (`tmp_historie_uzivatelu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;