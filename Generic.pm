package Config;

use Log::Log4perl qw(:easy);

# init Log4perl
Log::Log4perl->init(\q(
	log4perl.rootLogger = DEBUG, SCREEN
	log4perl.appender.SCREEN = Log::Log4perl::Appender::Screen
	log4perl.appender.SCREEN.layout = Log::Log4perl::Layout::PatternLayout
	log4perl.appender.SCREEN.layout.ConversionPattern = %d %l %p: %m%n
));
