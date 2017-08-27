package regex;
use Dancer ':syntax';
use Data::Dumper;
use Template;

our $VERSION = '0.1';

get '/' => sub {
	# my $params = {
	# 	session_id => session('id')
	# };
  template 'welcome';
};

any ['get', 'post'] => '/sectionContent/:sectionId/:problemId' => sub {
	my $sections = {
		'literals' => {
				'1' => {
						'title' => 'Literals',
						'description' => '',
						'problem' => 'Write a regex that matchs lines that have the string \':ERROR:\' in them, say, in a given log file.',
						'tests' => [
							{string => ':ERROR: NullPointerException - Null aya pani bharo', expected => 1, result => 0},
							{string => ':WARNING: Shukar hai error nahi aya', expected => 0, result => 0},
							{string => ':INFO: Bola na ERROR nahi aya', expected => 0, result => 0},
							{string => ':DEBUG: Zara pata karo :ERROR: kyon nahi aya', expected => 1, result => 0}
						]
					},
				'2' => {
					'title' => 'Literals',
					'description' => '',
					'problem' => 'Write a regex to look for occurrences of the getter call \'.getStudentName()\' in a particular java file.',
					'tests' => [
						{string => 'Student student = class.getStudent();', expected => 0, result => 0},
						{string => 'if (student.getStudentName() != null) {', expected => 1, result => 0},
						{string => '	return student.getStudentName()', expected => 1, result => 0},
						{string => '}', expected => 0, result => 0},
						{string => 'public String getStudentName() {', expected => 0, result => 0},
						{string => '  return name;', expected => 0, result => 0},
						{string => '}', expected => 0, result => 0},
					]
				},
			},
		'anything' => {
				'1' => {
					'title' => 'Match (almost) Anything',
					'description' => '',
					'problem' => 'Write a regex to look for occurrences of 
									the getter call \'.getStudentName()\' in a particular java file.',
					'tests' => [
						{string => 'Student student = class.getStudent();', expected => 0, result => 0},
						{string => 'if (student.getStudentName() != null) {', expected => 1, result => 0},
						{string => '	return student.getStudentName()', expected => 1, result => 0},
						{string => '}', expected => 0, result => 0},
						{string => 'public String getStudentName() {', expected => 0, result => 0},
						{string => '  return name;', expected => 0, result => 0},
						{string => '}', expected => 0, result => 0},
					]
				},				
			},
		'anchor' => {
				'1' => {
					'title' => 'Anchors',
					'description' => '',
					'problem' => 'Write a regex that matchs lines that \'start with\' the string \':ERROR:\' in them, say, in a given log file.',
					'tests' => [
						{string => ':ERROR: NullPointerException - Null aya pani bharo', expected => 1, result => 0},
						{string => ':WARNING: Shukar hai error nahi aya', expected => 0, result => 0},
						{string => ':INFO: Bola na ERROR nahi aya', expected => 0, result => 0},
						{string => ':DEBUG: Zara pata karo :ERROR: kyon nahi aya', expected => 0, result => 0}
					]
				},				
				'2' => {
					'title' => 'Anchors',
					'description' => '',
					'problem' => 'Write a regex to find lines in a text file that have Windows/DOS style line terminating characters. i.e. a \r followed by a \n.',
					'tests' => [
						{string => 'I terminate with in the Windows/DOS style\r\n', expected => 1, result => 0},
						{string => 'I terminate in the UNIX style\n', expected => 0, result => 0},
						{string => 'I terminate in the UNIX style\r\n but have a Windows/DOS style terminator in between the text\n', expected => 0, result => 0},
					],
				},
				'3' => {
					'title' => 'Anchors',
					'description' => '',
					'problem' => 'Write a regex to match lines that have just the single word \'WoRd\' in them.',
					'tests' => [
						{string => 'a line terminating with WoRd', expected => 0, result => 0},
						{string => 'WoRd at the start of a line', expected => 0, result => 0},
						{string => 'a line terminating with WoRd in the middle', expected => 0, result => 0},
						{string => 'WoRd', expected => 1, result => 0},
					],
				},
				'4' => {
					'title' => 'Anchors',
					'description' => '',
					'problem' => 'Write a regex that can be used to skip Unix style comments from a text file. 
					Where comment lines are defined as any line starting with the \'#\' charachter.',
					'tests' => [
						{string => '# I hate writing comments for code documentation', expected => 1, result => 0},
						{string => 'if the code was hard to write, it should be hard to understand too ;)', expected => 0, result => 0},
						{string => '# that was until I joined EE that is :)', expected => 1, result => 0},
						{string => ' # now I write code that is its own documentation', expected => 1, result => 0},
						{string => '	# I hope', expected => 1, result => 0},
					],
				},
			},
		'char-classes' => {
				'1' => {
					'title' => 'Character Classes',
					'description' => '',
					'problem' => 'Write a regex that can be used to skip Unix style comments from a text file. 
					Where comment lines are defined as any line starting with the \'#\' charachter.',
					'tests' => [
						{string => '# hate writing comments for code documentation', expected => 1, result => 0},
						{string => 'if the code was hard to write, it should be hard to understand too ;)', expected => 0, result => 0},
						{string => '# that was until I joined EE that is :)', expected => 1, result => 0},
						{string => ' # now I write code that is its own documentation', expected => 1, result => 0},
						{string => '	# I hope', expected => 1, result => 0},
					],
				},
				'2' => {
					'title' => 'Character Classes',
					'description' => '',
					'problem' => 'Write a regex that matches a \'sinle\' alpha-numeric character, with mixed case characters',
					'tests' => [
						{string => 'a', expected => 1, result => 0},
						{string => 'M', expected => 1, result => 0},
						{string => '@', expected => 0, result => 0},
						{string => '0', expected => 1, result => 0},
						{string => '5', expected => 1, result => 0},
						{string => '9', expected => 1, result => 0},
						{string => 'S0meth!ng', expected => 0, result => 0},
					],
				},
				'3' => {
					'title' => 'Character Classes',
					'description' => '',
					'problem' => 'Write a regex that matches a string that DOES NOT start with any of these special characters - !@#$',
					'tests' => [
						{string => '@expertals', expected => 0, result => 0},
						{string => '{var}', expected => 1, result => 0},
						{string => '${var}', expected => 0, result => 0},
						{string => 'var', expected => 1, result => 0},
					],
				},
			},
		'quantifiers' => {
				'1' => {
					'title' => 'Quantifiers',
					'description' => '',
					'problem' => 'Write a regex that can be used to skip Unix style comments from a text file. 
					Where comment lines are defined as any line starting with the \'#\' charachter.',
					'tests' => [
						{string => '# hate writing comments for code documentation', expected => 1, result => 0},
						{string => 'if the code was hard to write, it should be hard to understand too ;)', expected => 0, result => 0},
						{string => '# that was until I joined EE that is :)', expected => 1, result => 0},
						{string => ' # now I write code that is its own documentation', expected => 1, result => 0},
						{string => '	# I hope', expected => 1, result => 0},
					],
				},
				'2' => {
					'title' => 'Quantifiers',
					'description' => '',
					'problem' => 'Write a regex that matches a \'sigle\' alpha-numeric word, with mixed case characters',
					'tests' => [
						{string => 'asimpleword', expected => 1, result => 0},
						{string => 'aMixedWord', expected => 1, result => 0},
						{string => 'reallyM1xedW0rd', expected => 1, result => 0},
						{string => 'aCr@zyW0rd', expected => 0, result => 0},
						{string => '12345', expected => 1, result => 0},
						{string => '0xFF', expected => 1, result => 0},
						{string => 'notAl0ne %&', expected => 0, result => 0},
					],
				},
				'3' => {
					'title' => 'Quantifiers',
					'description' => '',
					'problem' => 'Write a regex that matches a \'sigle\' \'signed\' floating point number, with at least two digits decimal precision.',
					'tests' => [
						{string => '123', expected => 0, result => 0},
						{string => 'TwoThousand', expected => 0, result => 0},
						{string => '123.', expected => 0, result => 0},
						{string => '123.5', expected => 0, result => 0},
						{string => '.123', expected => 1, result => 0},
						{string => '0.123', expected => 1, result => 0},
						{string => '123.456', expected => 1, result => 0},
						{string => '-123.456', expected => 1, result => 0},
					],
					# ^-?[0-9]*\.[0-9]{2,}$
				},
				#TODO: greedy lazy
			},
		'grouping' => {
				'1' => {
					'title' => 'Grouping',
					'description' => '',
					'problem' => 'Write a regex that matches only the verb \'do\' and its \'present continuous tense\', but no other derived form.',
					'tests' => [
						{string => 'do', expected => 1, result => 0},
						{string => 'doing', expected => 1, result => 0},
						{string => 'doer', expected => 0, result => 0},
					],
					# ^-?[0-9]*\.[0-9]{2,}$
				},
				'2' => {
					'title' => 'Grouping',
					'description' => '',
					'problem' => 'Write a regex that matches a \'single\' \'signed\' floating point number, with exactly two digits decimal precision, with support for \'scientific notation\'.',
					'tests' => [
						{string => '123', expected => 0, result => 0},
						{string => 'TwoThousand', expected => 0, result => 0},
						{string => '123.', expected => 0, result => 0},
						{string => '123.5', expected => 0, result => 0},
						{string => '.123', expected => 0, result => 0},
						{string => '0.12', expected => 1, result => 0},
						{string => '123.45e6', expected => 1, result => 0},
						{string => '-123.456e78', expected => 0, result => 0},
						{string => '-123.456', expected => 0, result => 0},
						{string => '-123.45e6', expected => 1, result => 0},
						{string => '-123.45e6678', expected => 1, result => 0},
					],
					# ^-?[0-9]*\.[0-9]{2}(e[0-9]+)?$
				},
			},
		'alternation' => {
				'1' => {
					'title' => 'Alternation',
					'description' => '',
					'problem' => 'Write a regex that matchs lines that \'start with\' the string \':ERROR:\' or \':WARNING:\' in them, say, in a given log file.',
					'tests' => [
						{string => ':ERROR: NullPointerException - Null aya pani bharo', expected => 1, result => 0},
						{string => ':WARNING: Shukar hai error nahi aya', expected => 1, result => 0},
						{string => ':INFO: Bola na ERROR nahi aya', expected => 0, result => 0},
						{string => ':DEBUG: Zara pata karo :ERROR: kyon nahi aya', expected => 0, result => 0}
					]
					# ^:(ERROR|WARNING):
				},
				'2' => {
					'title' => 'Alternation',
					'description' => '',
					'problem' => 'Match a complete string with this format \'Did you know today is &lt;valid-day-of-week&gt;?\'. Where day-of-week is in \'ddd\' format, with a possible mixed-case first letter.',
					'tests' => [
						{string => 'Did you know today is Fri? Yahoo! the weekend is almost here...', expected => 0, result => 0},
						{string => 'Did you know today is Mon?', expected => 1, result => 0},
						{string => 'Did you know today is Tue?', expected => 1, result => 0},
						{string => 'Did you know today is Wed?', expected => 1, result => 0},
						{string => 'Did you know today is Thu?', expected => 1, result => 0},
						{string => 'Did you know today is Fri?', expected => 1, result => 0},
						{string => 'Did you know today is mon?', expected => 1, result => 0},
						{string => 'Did you know today is tue?', expected => 1, result => 0},
						{string => 'Did you know today is wed?', expected => 1, result => 0},
						{string => 'Did you know today is thu?', expected => 1, result => 0},
						{string => 'Did you know today is fri?', expected => 1, result => 0},
						{string => 'Did you know today is TraditionalDay?', expected => 0, result => 0},
					]
					# ^Did you know today is ([Mm]on|[Tt]ue|[Ww]ed|[Tt]hu|[Ff]ri)\?$
				},
			},
		'capturing' => {
				'1' => {
					'title' => 'Capturing and Backreferences',
					'description' => '',
					'problem' => 'Match names of hindi \'three-word\' movies, where the first and third word is the same!',
					'tests' => [
						{string => 'Sholay', expected => 0, result => 0},
						{string => 'Mera Naam Joker', expected => 0, result => 0},
						{string => 'Jane Bhi Do Yaaron', expected => 0, result => 0},
						{string => 'Bol Radha Bol', expected => 1, result => 0},
						{string => 'Karthik Calling Karthik', expected => 1, result => 0},
						{string => 'Bhag Milkha Bhag', expected => 1, result => 0},
					],
					# ^([A-Za-z]+) [A-Za-z]+ \1$
				},
			},
		# 'modifiers' => {
		# 		'1' => {
		# 			'title' => '',
		# 			'description' => '',
		# 			'problem' => '',
		# 			'tests' => [
		# 				{strung => '', expected => 1, result => 0},
		# 			],
		# 		},
		# 	},
		# 'look-around' => {
		# 		'1' => {
		# 			'title' => '',
		# 			'description' => '',
		# 			'problem' => '',
		# 			'tests' => [
		# 				{strung => '', expected => 1, result => 0},
		# 			],
		# 		},
		# 	},
		};

	debug Dumper(params);
	
	my $params = {};
	$params->{badPattern} = 0;

	my $sectionId = params->{'sectionId'};
	$params->{sectionId} = $sectionId;

	my $activeProblemId = params->{'problemId'};
	$params->{problemId} = $activeProblemId;

	my $sectionContent = $sections->{$sectionId}->{$activeProblemId};
	$params->{sectionContent} = $sectionContent;

	$params->{problems} = [];
	for my $problemId (sort(keys(%{$sections->{$sectionId}}))) {
		push @{$params->{problems}}, {id=>$problemId, active => ($problemId == $activeProblemId ? 1 : 0)}
	}

	my $regex = params->{'regex'};
	$params->{regex} = $regex;

	if ($regex) {
		my $pattern;
		eval '$pattern = qr/$regex/';
		if ($@) {
			$params->{badPattern} = 1;
		}
		else {
			debug "Pattern = /$pattern/\n";
			for my $test (@{$sectionContent->{tests}}) {
				if ($test->{string} =~ $pattern) {
					$test->{result} = 1 if $test->{expected};
				}
				else {
					$test->{result} = 1 unless $test->{expected};
				}
			}			
		}
	}

	template 'sectionContent', $params;
};

true;