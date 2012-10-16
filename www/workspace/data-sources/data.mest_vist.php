<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcemest_vist extends SectionDatasource{

		public $dsParamROOTELEMENT = 'mest-vist';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '3';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'system:id';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		

		

		public $dsParamINCLUDEDELEMENTS = array(
				'navn',
				'nokkelord',
				'skjermbilder: bilde',
				'skjermbilder: hoved'
		);
		

		public function __construct($env=NULL, $process_params=true){
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about(){
			return array(
				'name' => 'Mest vist',
				'author' => array(
					'name' => 'Frode Danielsen',
					'website' => 'http://webapps.local:8080',
					'email' => 'frode@e5r.no'),
				'version' => 'Symphony 2.3.1RC1',
				'release-date' => '2012-10-07T23:12:06+00:00'
			);
		}

		public function getSource(){
			return '2';
		}

		public function allowEditorToParse(){
			return true;
		}

	}
