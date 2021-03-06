# wgHeader.pm
# Webglimpse header file. Contains constants used by many modules in the system.

package wgHeader;

require Exporter;

use vars qw( @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS );

@ISA = qw(Exporter);

$VERSION = "2.21.0";

##############################################################
# General use constants - imported automatically (plus one variable - lastError)
#
my @GENERAL = qw($WGHOME $WGEXT $lastError $ADMIN_EMAIL $SENDMAIL $ARCHFILE $WGARCHIVE_DIR $PERL $CAT $GLIMPSE_LOC $GLIMPSEIDX_LOC $CONVERT_LOC $CGIBIN $WWWUID $FILE_END_MARK $WEBGLIMPSE_LIB $WEBGLIMPSE_DIST $CONFIGFILE $SITECONF $ARCHIVE_LIST $WGTEMPLATES $HTML2TXTPROG $DOCURL $PASSFILE $HTTPGET_CMD $CATFILE $WUSAGE $WUSAGE_DIR $LANG %VALID_LANG $VERSION $TMPDIR $WRREPOS $SEARCH_STATIC_DIR $MAKE_STATIC_SEARCH_PAGES $SEARCH_STATIC_BASEURL);

# Install actually gets all variables, including these
my @INSTALL = qw($USRBIN_DIR $CGIBIN_DIR $REGISTER_ARCHIVES);

# All of the following variables will be overwritten by wginstall
## STARTVARS #########################
$WGHOME = "/usr/local/wg2";
$WGARCHIVE_DIR = "/usr/local/wg2/archives"; 	# Must be web-writable to use web administration interface
$ADMIN_EMAIL = 'root@localhost';
$SENDMAIL = "/usr/lib/sendmail";
$CGIBIN_DIR = "/home/httpd/cgi-bin/wg2";
$USRBIN_DIR = "/usr/local/bin";
$PERL = "/usr/local/bin/perl";
$CAT = "/bin/cat";
$RM = "/bin/rm";
$WUSAGE = "/usr/local/bin/wusage";
$WUSAGE_DIR = "";		# Default will be DOCROOT/wusage, but must be blank before install
$GLIMPSE_LOC = "/usr/local/bin/glimpse";
$GLIMPSEIDX_LOC = "/usr/local/bin/glimpseindex";
$CONVERT_LOC = "/usr/local/bin/wgconvert";
$CGIBIN = "cgi-bin/wg2";
$WWWUID = "444";		
$HTTPGET_CMD = 'httpget';
$HTML2TXTPROG = 'html2txt';
$CATFILE = "wgODP3.dbm";
$FILE_END_MARK = " ";  # MUST match setting in glimpse.h 
               # Set to other than space to index filenames with spaces in them.

# To generate static pages corresponding to user searches (may allow users to also have personal notes)
$SEARCH_STATIC_DIR = '';
$SEARCH_STATIC_BASEURL = '';
$MAKE_STATIC_SEARCH_PAGES = 0;

## ENDVARS ###########################
# End overwritten variables

$WRREPOS = 0;           # to use webglimpse as a  scientifig reprints repository [TT]

$TMPDIR = '/tmp';	# may want to set this in wginstall too

$WGEXT = 'abra';

# Address where new archive information is sent, if registration is allowed
$REGISTER_AT = 'admin@webglimpse.net';

# Make sure we can find our other libraries
$WEBGLIMPSE_LIB = "$WGHOME/lib";
$WEBGLIMPSE_DIST = "$WGHOME/dist";
$WGTEMPLATES = "$WGHOME/templates";
 
 
# name of config file
$CONFIGFILE = "archive.cfg";

# name of file containing all archive info
$ARCHIVE_LIST = 'archives.list';

# name of domain/site config file
$SITECONF = "wgsites.conf";
$OLDSITECONF = ".wgsiteconf";

# administrator password file for use with cookies
$PASSFILE = ".wgpasswd";

$lastErr = '';

$DOCURL = "http://webglimpse.net/docs/";

# End automatically imported vars
###############################################################

# The following vars must be used explicitly by each module that wants them

###############################################################
##############################################################
# Used by wgConf.pm wgArch.pm  and wgarcmin
my @CONF = qw($PasswordFile $DocURL $PageTemplateLink $PageTemplateSite $PageTemplateDir $REGISTER_AT $REGISTER_ARCHIVES);
my @ARCH = qw($ARCHIVE_LIST $LOGFILE $WUSAGE_DIR $WUSAGE $REGISTER_ARCHIVES $REGISTER_AT);

$DocURL = "http://webglimpse.net/docs/wgarcmin.html";
$PasswordFile = "$WGHOME/.wgpasswd";

$PageTemplateLink = "$WGHOME/dist/.wgtemplate_link";
$PageTemplateSite = "$WGHOME/dist/.wgtemplate_site";
$PageTemplateDir = "$WGHOME/dist/.wgtemplate_dir";



################################################################
# Used by makenh, wgConf, wgRoot
my @MAKENH = qw ($nh_pre $HTMLFILE_RE $SITE_RE $URL_ERROR $URL_LOCAL $URL_REMOTE $URL_SCRIPT $URL_TRAVERSE $HTTPGET_CMD $GETURL_CMD $GLIMPSEIDX_OPTIONS $CRONFILE $WRCRONFILE $TOINDEX $MADENH $LOCKFILE $GHROBOT $ADDSEARCH $TEMPROBOTFILE $MAPFILE $REMOTEDIR $CACHEDIR $TMPREMOTEDIR $WGINDEX $GFILTERS $MADENH $FLISTFNAME $ERRFILENAME $LOGFILENAME $WGADDSEARCH $ROBOTNAME $DIR $SITE $TREE $DEFAULT_PORT $SEARCHBOX);  

$nh_pre = ".nh.";
$GETURL_CMD = "$WEBGLIMPSE_LIB/url_get";

# files and dirs in the archivepwd
$TEMPROBOTFILE = "robots.tmp";
$MAPFILE= ".wgmapfile";
$REMOTEDIR = ".remote";
$CACHEDIR = ".cache";
$TMPREMOTEDIR = ".remote.old";
$WGINDEX = ".wgfilter-index";
$GFILTERS = ".glimpse_filters";
$MADENH = ".wg_madenh";
$FLISTFNAME = ".wg_toindex";
$ERRFILENAME = ".wg_err";
$LOGFILENAME = ".wg_log";
# $STARTFILE = ".wgstart";
$WGADDSEARCH = ".wgfilter-box";
$LOCKFILE = "indexing-in-progress";
$GHROBOT = "$WGHOME/makenh";
$ADDSEARCH = "$WGHOME/addsearch";
$SEARCHBOX = "wgbox.html";	# no longer hidden file, we encourage users to edit
$CRONFILE = "wgreindex";
$WRCRONFILE = "wrwgreindex";    # to use Webglimpse as a scientific reprints repository [TT]
$TOINDEX = ".wg_toindex";
$MADENH = ".wg_madenh";
$GLIMPSEIDX_OPTIONS = "-t -z -h -X -U -f -C -F";  # Removed -o added -z  --GB 5/31/99

# Possible states of a URL
$URL_ERROR=0;
$URL_LOCAL=1;
$URL_REMOTE=2;
$URL_SCRIPT=3;
$URL_TRAVERSE=4;

$HTMLFILE_RE = "((\.s?html)|(\.sht)|(\.htm)|(\.php.?)|(\.asp)|(\.abra))\$";
$SITE_RE = '[^:]+:\/\/([^\/]+)\/.*';

$ROBOTNAME = "HTTPGET";

#############################################
# wgRoot only cares about these
my @WGROOT = qw( $DIR $SITE $TREE $DEFAULT_PORT $URL_ERROR $URL_LOCAL $URL_REMOTE $URL_SCRIPT $URL_TRAVERSE);

$DEFAULT_PORT = 80;

# Types of Roots (an archive consists of a set of roots) in old-style config files
# (new config files use text, 'DIR', 'TREE', or 'SITE' )
$DIR = 2;
$TREE = 1;
$SITE = 0;

#################################################
# used by wgLog
my @WGLOG = qw ( $LOGFILE $NOT_MODIFIED $NOT_FOUND $FOUND @MONTHS $WUSAGE_DIR);

$LOGFILE = 'searches.log';
$NOT_MODIFIED = 304; 
$NOT_FOUND = 404;
$FOUND = 200;
@MONTHS = ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');


@EXPORT = ( @GENERAL );
@EXPORT_OK = ( @MAKENH, @CONF, @ARCH, @WGLOG, @INSTALL, @GENERAL );

%EXPORT_TAGS = (
    'all'      => [ @EXPORT_OK ],
    'makenh'   => [ @MAKENH ],
    'conf'     => [ @CONF ],
    'wgroot'   => [ @WGROOT ],
    'wgarch'   => [ @ARCH ],
    'wglog'    => [ @WGLOG ],
    'install'  => [ @INSTALL ],
    'general'  => [ @GENERAL ]
);

1;
