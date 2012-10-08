<?php

	require_once(TOOLKIT . '/class.event.php');

	Class eventsend_tips extends Event{

		const ROOTELEMENT = 'send-tips';

		public $eParamFILTERS = array(
			
		);

		public static function about(){
			return array(
				'name' => 'Send tips',
				'author' => array(
					'name' => 'Frode Danielsen',
					'website' => 'http://webapps',
					'email' => 'frode@e5r.no'),
				'version' => 'Symphony 2.2.2',
				'release-date' => '2011-08-09T12:58:03+00:00',
				'trigger-condition' => 'action[send-tips]'
			);
		}

		public static function getSource(){
			return '2';
		}

		public static function allowEditorToParse(){
			return false;
		}

		public static function documentation(){
			return '
        <h3>Success and Failure XML Examples</h3>
        <p>When saved successfully, the following XML will be returned:</p>
        <pre class="XML"><code>&lt;send-tips result="success" type="create | edit">
  &lt;message>Entry [created | edited] successfully.&lt;/message>
&lt;/send-tips></code></pre>
        <p>When an error occurs during saving, due to either missing or invalid fields, the following XML will be returned:</p>
        <pre class="XML"><code>&lt;send-tips result="error">
  &lt;message>Entry encountered errors when saving.&lt;/message>
  &lt;field-name type="invalid | missing" />
  ...
&lt;/send-tips></code></pre>
        <h3>Example Front-end Form Markup</h3>
        <p>This is an example of the form markup you can use on your frontend:</p>
        <pre class="XML"><code>&lt;form method="post" action="" enctype="multipart/form-data">
  &lt;input name="MAX_FILE_SIZE" type="hidden" value="2097152" />
  &lt;label>Navn
    &lt;input name="fields[navn]" type="text" />
  &lt;/label>
  &lt;label>Nettside
    &lt;input name="fields[nettside]" type="text" />
  &lt;/label>
  &lt;label>Undertittel
    &lt;input name="fields[undertittel]" type="text" />
  &lt;/label>
  &lt;label>Beskrivelse
    &lt;textarea name="fields[beskrivelse]" rows="15" cols="50">&lt;/textarea>
  &lt;/label>
  &lt;label>Registrering
    &lt;input name="fields[registrering]" type="text" />
  &lt;/label>
  &lt;label>Facebook-side
    &lt;input name="fields[facebook-side]" type="text" />
  &lt;/label>
  &lt;label>Fra månedspris
    &lt;input name="fields[fra-manedspris]" type="text" />
  &lt;/label>
  &lt;label>Prøveperiode
    &lt;input name="fields[proveperiode]" type="checkbox" />
  &lt;/label>
  &lt;select name="fields[utvikler]">
    &lt;option value="...">...&lt;/option>
  &lt;/select>
  &lt;select name="fields[skjermbilder]">
    &lt;option value="...">...&lt;/option>
  &lt;/select>
  &lt;input name="action[send-tips]" type="submit" value="Submit" />
&lt;/form></code></pre>
        <p>To edit an existing entry, include the entry ID value of the entry in the form. This is best as a hidden field like so:</p>
        <pre class="XML"><code>&lt;input name="id" type="hidden" value="23" /></code></pre>
        <p>To redirect to a different location upon a successful save, include the redirect location in the form. This is best as a hidden field like so, where the value is the URL to redirect to:</p>
        <pre class="XML"><code>&lt;input name="redirect" type="hidden" value="http://webapps/success/" /></code></pre>';
		}

		public function load(){
			if (isset($_POST['action'][self::ROOTELEMENT])) {
				return $this->__trigger();
			}
		}

		protected function __trigger(){

			include_once(TOOLKIT . '/class.sectionmanager.php');
			include_once(TOOLKIT . '/class.entrymanager.php');

			/*
			 * How to get a section from the section manager through it's handle:
			 */
			$sectionManager = new SectionManager(Symphony::Engine());
			$section_id = $sectionManager->fetchIDFromHandle('bedrift');
			$section = $sectionManager->fetch($bedriftID);

			/*
			 * How to create a section entry through the entry manager:
			 */
			$entryManager = new EntryManager(Symphony::Engine());

			$post = General::getPostData();

			if (!empty($post['fields']['nytt-skjermklipp'])) {
				$screen_section_id = $sectionManager->fetchIDFromHandle('skjermbilde');

				$screens = $post['fields']['nytt-skjermklipp'];
				foreach ($screens as $screen) {
					if (empty($screen['bilde'])
							|| $screen['bilde']['error'] !== 0) continue;

					$entry = $entryManager->create();
					$entry->set('section_id', $screen_section_id);

					if (__ENTRY_OK__ == $entry->checkPostData($screen, $errors, false)) {
						if (__ENTRY_OK__ == $entry->setDataFromPost($screen, $errors, false, false)) {
							if ($entry->commit()) {
								$_POST['fields']['skjermbilder'][] = $entry->get('id');
							}
						}
					}
				}
			}

			if ($post['fields']['utvikler'] == '+') {
				$entry = $entryManager->create();
				$entry->set('section_id', $section_id);

				if (__ENTRY_OK__ == $entry->checkPostData($post['fields']['ny-utvikler'], $errors, false)) {
					if (__ENTRY_OK__ == $entry->setDataFromPost($post['fields']['ny-utvikler'], $errors, false, false)) {
						if (!$entry->commit()) {
							$errors[] = __('Unknown errors where encountered when saving.');
						}
					}
				}

				if (!empty($errors)) {
					// Handle errors...
					//var_dump($errors);
					$_POST['fields']['utvikler'] = null;
				}
				else {
					// Change the main section field to a sub section entry reference
					$_POST['fields']['utvikler'] = $entry->get('id');
				}
			}

			$_POST['fields']['opprettet'] = time();

			// Let the default section event to create the main entry
			include(TOOLKIT . '/events/event.section.php');
			return $result;
		}

	}
