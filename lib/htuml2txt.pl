#!/usr/local/bin/perl

# converts html files into ascii by just stripping anything between
#  < and >
# written 4/21/96 by Michael Smith for WebGlimpse
#
# Added code to replace html codes for special chars with the
# characters themselves.  12/19/98 --GB
#
# Also add space in place of space-producing HTML tags
# 12/22/98 --GB


BEGIN{
        $WEBGLIMPSE_LIB = '|WEBGLIMPSE_LIB|';
        unshift(@INC, "$WEBGLIMPSE_LIB");  # Find the rest of our libs
} 
use wgFilter;


$SAVE_LINE_MARK = '_~_';


$carry=0;
$lineno = -1;
$incomplete_tag = 0;
$last_incomplete_tag = 0;

@lines = <STDIN>;

&wgFilter::SkipSection('<SCRIPT\s*[^>]*>','<\/SCRIPT>',\@lines);
&wgFilter::SkipSection('<STYLE\s*[^>]*>','<\/STYLE>',\@lines);

foreach $line (@lines){
	$lineno++;	# we need line number in ORIGINAL file for jump-to-line later

	# put returns back in in case user uploaded wrong
	$line =~ s/\r\n/\n/g;

# if we put in extra returns, not every line will start with <linenum>
# take out for now, consider putting back in with <linenum> inserted
#	$line =~ s/\r/\n/g;

	# now take out the ones we don't want!
	$line =~ s/([^>\.\s])\n/$1 /g;
	$line =~ s/(\s)\n/$1/g;

	if($carry==1){
		# remove all until the first >
		next if($line!~s/[^>]*>//);
		# if we didn't do next, it succeeded -- reset carry
		$carry=0;
	} 

	# save <TITLE, <A, <FRAME, <BASE tags
	$line =~ s/<(\/?)(title|a|frame|base)/#~#$1$2/ig;

	while($line=~s/(<[^\s>][^>]*>)/&addspace($1,$lineno)/ge){};

	if($line=~s/<[^\s>].*$//){
		$carry=1;
	}

	# put saved tags back, and check if the tag is complete
	if ($line =~ /#~#[^>]*$/) {
		$incomplete_tag = 1;
	} else {
		$incomplete_tag = 0;
	}
	$line =~ s/#~#(\/?)(title|a|frame|base)/<$1$2/ig;	

	# put lineno tags back
	$line =~ s/$SAVE_LINE_MARK([0-9]+)$SAVE_LINE_MARK/<$1>/g;

	# If we may have a html-encoded char, check and replace with actual char
	if ($line =~ /\&[^;]{2,6};/) {
		$line = &fixspecial($line);
	}
	if ($line) {
		if (! $last_incomplete_tag) {
			print "<$lineno>";
		}
		print $line;
	}
	if (!$last_incomplete_tag || $line =~ />/) {
		$last_incomplete_tag = $incomplete_tag;
#$last_incomplete_tag && warn "Line $line is incomplete\n";
	}
}


sub addspace () {

	$_ = shift;
	my $lineno = shift;
		
	# Check for tags that should NOT return a space.  Common tags first, then group alphabeticallly
	/(<\/?a[\s>])|(<\/?b>)|(<\/?i>)|(<\/?em>)|(<\/?font)/i && return '';
	/(<\/?strong)|(<\/?sup)|(<\/?sub)|(<\/?samp)|(<\/?strike)|(<\/?style)|(<\/?small)/i && return;
	/(<\/?big)|(<\/?base)|(<\/?cite)|(<\/?code)|(<\/?dfn)|(<\/?kbd)|(<\/?link)|(<\/?meta)/i && return;
	/(<\/?tt>)|(<\/?u>)|(<\/?var)/i && return '';

	# Check for tags that need a return for a record break.
	# insert <linenumber> at the beginning of the next line
	/(<\/?p[\s>])|(<\/?br[\s>])|(<\/?tr[\s>])|(<\/?hr[\s>])|(<\/?li[\s>])/i && return "\n$SAVE_LINE_MARK$lineno$SAVE_LINE_MARK";


	# Otherwise, put in a space
	return ' ';

}


sub fixspecial () {

	$_ = shift;

s/\&#160;/ /g;
s/\&nbsp;/ /g;
s/\&#161;/�/g;
s/\&iexcl;/�/g;
s/\&#162;/�/g;
s/\&cent;/�/g;
s/\&#163;/�/g;
s/\&pound;/�/g;
s/\&#164;/�/g;
s/\&curren;/�/g;
s/\&#165;/�/g;
s/\&yen;/�/g;
s/\&#166;/�/g;
s/\&brvbar;/�/g;
s/\&#167;/�/g;
s/\&sect;/�/g;
s/\&#168;/�/g;
s/\&uml;/�/g;
s/\&#169;/�/g;
s/\&copy;/�/g;
s/\&#170;/�/g;
s/\&ordf;/�/g;
s/\&#171;/�/g;
s/\&laquo;/�/g;
s/\&#172;/�/g;
s/\&not;/�/g;
s/\&#173;/\\/g;
s/\&shy;/\\/g;
s/\&#174;/�/g;
s/\&reg;/�/g;
s/\&#175;/�/g;
s/\&macr;/�/g;
s/\&#176;/�/g;
s/\&deg;/�/g;
s/\&#177;/�/g;
s/\&plusmn;/�/g;
s/\&#178;/�/g;
s/\&sup2;/�/g;
s/\&#179;/�/g;
s/\&sup3;/�/g;
s/\&#180;/�/g;
s/\&acute;/�/g;
s/\&#181;/�/g;
s/\&micro;/�/g;
s/\&#182;/�/g;
s/\&para;/�/g;
s/\&#183;/�/g;
s/\&middot;/�/g;
s/\&#184;/�/g;
s/\&cedil;/�/g;
s/\&#185;/�/g;
s/\&sup1;/�/g;
s/\&#186;/�/g;
s/\&ordm;/�/g;
s/\&#187;/�/g;
s/\&raquo;/�/g;
s/\&#188;/�/g;
s/\&frac14;/�/g;
s/\&#189;/�/g;
s/\&frac12;/�/g;
s/\&#190;/�/g;
s/\&frac34;/�/g;
s/\&#191;/�/g;
s/\&iquest;/�/g;
s/\&#192;/�/g;
s/\&Agrave;/�/g;
s/\&#193;/�/g;
s/\&Aacute;/�/g;
s/\&#194;/�/g;
s/\&circ;/�/g;
s/\&#195;/�/g;
s/\&Atilde;/�/g;
s/\&#196;/�/g;
s/\&Auml;/�/g;
s/\&#197;/�/g;
s/\&ring;/�/g;
s/\&#198;/�/g;
s/\&AElig;/�/g;
s/\&#199;/�/g;
s/\&Ccedil;/�/g;
s/\&#200;/�/g;
s/\&Egrave;/�/g;
s/\&#201;/�/g;
s/\&Eacute;/�/g;
s/\&#202;/�/g;
s/\&Ecirc;/�/g;
s/\&#203;/�/g;
s/\&Euml;/�/g;
s/\&#204;/�/g;
s/\&Igrave;/�/g;
s/\&#205;/�/g;
s/\&Iacute;/�/g;
s/\&#206;/�/g;
s/\&Icirc;/�/g;
s/\&#207;/�/g;
s/\&Iuml;/�/g;
s/\&#208;/�/g;
s/\&ETH;/�/g;
s/\&#209;/�/g;
s/\&Ntilde;/�/g;
s/\&#210;/�/g;
s/\&Ograve;/�/g;
s/\&#211;/�/g;
s/\&Oacute;/�/g;
s/\&#212;/�/g;
s/\&Ocirc;/�/g;
s/\&#213;/�/g;
s/\&Otilde;/�/g;
s/\&#214;/�/g;
s/\&Ouml;/�/g;
s/\&#215;/�/g;
s/\&times;/�/g;
s/\&#216;/�/g;
s/\&Oslash;/�/g;
s/\&#217;/�/g;
s/\&Ugrave;/�/g;
s/\&#218;/�/g;
s/\&Uacute;/�/g;
s/\&#219;/�/g;
s/\&Ucirc;/�/g;
s/\&#220;/�/g;
s/\&Uuml;/�/g;
s/\&#221;/�/g;
s/\&Yacute;/�/g;
s/\&#222;/�/g;
s/\&THORN;/�/g;
s/\&#223;/�/g;
s/\&szlig;/�/g;
s/\&#224;/�/g;
s/\&agrave;/�/g;
s/\&#225;/�/g;
s/\&aacute;/�/g;
s/\&#226;/�/g;
s/\&acirc;/�/g;
s/\&#227;/�/g;
s/\&atilde;/�/g;
s/\&#228;/�/g;
s/\&auml;/�/g;
s/\&#229;/�/g;
s/\&aring;/�/g;
s/\&#230;/�/g;
s/\&aelig;/�/g;
s/\&#231;/�/g;
s/\&ccedil;/�/g;
s/\&#232;/�/g;
s/\&egrave;/�/g;
s/\&#233;/�/g;
s/\&eacute;/�/g;
s/\&#234;/�/g;
s/\&ecirc;/�/g;
s/\&#235;/�/g;
s/\&euml;/�/g;
s/\&#236;/�/g;
s/\&igrave;/�/g;
s/\&#237;/�/g;
s/\&iacute;/�/g;
s/\&#238;/�/g;
s/\&icirc;/�/g;
s/\&#239;/�/g;
s/\&iuml;/�/g;
s/\&#240;/�/g;
s/\&ieth;/�/g;
s/\&#241;/�/g;
s/\&ntilde;/�/g;
s/\&#242;/�/g;
s/\&ograve;/�/g;
s/\&#243;/�/g;
s/\&oacute;/�/g;
s/\&#244;/�/g;
s/\&ocirc;/�/g;
s/\&#245;/�/g;
s/\&otilde;/�/g;
s/\&#246;/�/g;
s/\&ouml;/�/g;
s/\&#247;/�/g;
s/\&divide;/�/g;
s/\&#248;/�/g;
s/\&oslash;/�/g;
s/\&#249;/�/g;
s/\&ugrave;/�/g;
s/\&#250;/�/g;
s/\&uacute;/�/g;
s/\&#251;/�/g;
s/\&ucirc;/�/g;
s/\&#252;/�/g;
s/\&uuml;/�/g;
s/\&#253;/�/g;
s/\&yacute;/�/g;
s/\&#254;/�/g;
s/\&thorn;/�/g;
s/\&#255;/�/g;
s/\&yuml;/�/g;
s/\&#34;/"/g;
s/\&quot;/"/g;

# Do the ampersand last, so it won't affect the other substitutions
s/\&#38;/\&/g;
s/\&amp;/\&/g;

	return $_;
}
