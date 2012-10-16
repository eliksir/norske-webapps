<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcemerkelapper extends SectionDatasource{

		public $dsParamROOTELEMENT = 'merkelapper';
		public $dsParamORDER = 'asc';
		public $dsParamPAGINATERESULTS = 'no';
		public $dsParamLIMIT = '20';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'system:id';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'yes';
		

		

		public $dsParamINCLUDEDELEMENTS = array(
				'navn'
		);
		

		public function __construct($env=NULL, $process_params=true){
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about(){
			return array(
				'name' => 'Merkelapper',
				'author' => array(
					'name' => 'Frode Danielsen',
					'website' => 'http://webapps.local:8080',
					'email' => 'frode@e5r.no'),
				'version' => 'Symphony 2.3.1RC1',
				'release-date' => '2012-10-07T23:42:40+00:00'
			);
		}

		public function getSource(){
			return '5';
		}

		public function allowEditorToParse(){
			return true;
		}

	}
