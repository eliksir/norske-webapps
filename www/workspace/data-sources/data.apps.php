<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourceapps extends Datasource{

		public $dsParamROOTELEMENT = 'apps';
		public $dsParamORDER = 'asc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '20';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'navn';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

		public $dsParamFILTERS = array(
				'22' => '{$url-type}',
		);

		public $dsParamINCLUDEDELEMENTS = array(
				'navn',
				'skjermbilder: bilde',
				'skjermbilder: hoved',
				'nokkelord'
		);


		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}

		public function about(){
			return array(
				'name' => 'Apps',
				'author' => array(
					'name' => 'Frode Danielsen',
					'website' => 'http://webapps',
					'email' => 'frode@e5r.no'),
				'version' => 'Symphony 2.2.2',
				'release-date' => '2011-08-11T15:52:33+00:00'
			);
		}

		public function getSource(){
			return '2';
		}

		public function allowEditorToParse(){
			return false;
		}

		/**
		 * Customize parameter processing to force an empty result from this data source if
		 * a specific app is requested through an URL parameter. In such a case, we should rely
		 * on the vis_app data source.
		 */
		public function processParameters (Array $env = array()) {
			parent::processParameters($env);

			$app = Datasource::findParameterInEnv('app', $env);
			if ($app !== null && trim($app) !== '') {
				$this->_force_empty_result = true;
				$this->dsParamPARAMOUTPUT = null;
				$this->dsParamINCLUDEDELEMENTS = null;
			}
			else {
				$sort = Datasource::findParameterInEnv('url-sort', $env);
				if ($sort !== null) {
					$this->dsParamSORT = $sort;
					$this->dsParamORDER = $sort !== 'navn' ? 'desc' : 'asc';
				}
			}
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
