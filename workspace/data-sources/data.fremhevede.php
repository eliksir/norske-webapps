<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcefremhevede extends SectionDatasource{

		public $dsParamROOTELEMENT = 'fremhevede';
		public $dsParamORDER = 'random';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '4';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'system:id';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		

		

		public $dsParamINCLUDEDELEMENTS = array(
				'navn',
				'undertittel',
				'utvikler: navn',
				'utvikler: nettside',
				'skjermbilder: bilde',
				'skjermbilder: hoved'
		);
		

		public function __construct($env=NULL, $process_params=true){
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about(){
			return array(
				'name' => 'Fremhevede',
				'author' => array(
					'name' => 'Frode Danielsen',
					'website' => 'http://webapps.local:8080',
					'email' => 'frode@e5r.no'),
				'version' => 'Symphony 2.3.1RC1',
				'release-date' => '2012-10-07T23:08:32+00:00'
			);
		}

		public function getSource(){
			return '2';
		}

		public function allowEditorToParse(){
			return true;
		}

	}
