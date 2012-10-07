<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcevis_app extends SectionDatasource{

		public $dsParamROOTELEMENT = 'vis-app';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'no';
		public $dsParamLIMIT = '20';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamREQUIREDPARAM = '$app';
		public $dsParamSORT = 'system:id';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		

		public $dsParamFILTERS = array(
				'1' => '{$app}',
		);
		

		public $dsParamINCLUDEDELEMENTS = array(
				'system:date',
				'navn',
				'undertittel',
				'utvikler: navn',
				'utvikler: nettside',
				'fra-manedspris',
				'proveperiode',
				'nettside',
				'registrering',
				'facebook-side',
				'skjermbilder: bilde',
				'skjermbilder: hoved',
				'nokkelord',
				'opprettet'
		);
		

		public function __construct($env=NULL, $process_params=true){
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about(){
			return array(
				'name' => 'Vis app',
				'author' => array(
					'name' => 'Frode Danielsen',
					'website' => 'http://webapps.local:8080',
					'email' => 'frode@e5r.no'),
				'version' => 'Symphony 2.3.1RC1',
				'release-date' => '2012-10-07T23:47:52+00:00'
			);
		}

		public function getSource(){
			return '2';
		}

		public function allowEditorToParse(){
			return true;
		}

	}
