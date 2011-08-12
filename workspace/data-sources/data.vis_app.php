<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcevis_app extends Datasource{

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
				'3' => '{$app}',
		);

		public $dsParamINCLUDEDELEMENTS = array(
				'navn',
				'nettside',
				'undertittel',
				'beskrivelse: formatted',
				'registrering',
				'facebook-side',
				'fra-manedspris',
				'proveperiode',
				'utvikler',
				'skjermbilder',
				'nokkelord',
				'visninger: increment',
				'oppdatert',
				'opprettet'
		);


		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}

		public function about(){
			return array(
				'name' => 'Vis app',
				'author' => array(
					'name' => 'Frode Danielsen',
					'website' => 'http://webapps',
					'email' => 'frode@e5r.no'),
				'version' => 'Symphony 2.2.2',
				'release-date' => '2011-08-12T15:36:02+00:00'
			);
		}

		public function getSource(){
			return '2';
		}

		public function allowEditorToParse(){
			return true;
		}

		public function grab(&$param_pool=NULL){
			$result = new XMLElement($this->dsParamROOTELEMENT);

			try{
				include(TOOLKIT . '/data-sources/datasource.section.php');
			}
			catch(FrontendPageNotFoundException $e){
				// Work around. This ensures the 404 page is displayed and
				// is not picked up by the default catch() statement below
				FrontendPageNotFoundExceptionHandler::render($e);
			}
			catch(Exception $e){
				$result->appendChild(new XMLElement('error', $e->getMessage()));
				return $result;
			}

			if($this->_force_empty_result) $result = $this->emptyXMLSet();

			

			return $result;
		}

	}
