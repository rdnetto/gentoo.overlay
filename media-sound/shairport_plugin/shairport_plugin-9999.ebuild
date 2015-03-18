# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils git-r3

DESCRIPTION="ShairPort Squeezebox Server Plugin - airTunes for Squeezebox clients"
HOMEPAGE="https://github.com/StuartUSA/shairport_plugin/"
EGIT_REPO_URI="git://github.com/StuartUSA/shairport_plugin.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-perl/Crypt-OpenSSL-RSA
	dev-perl/IO-Socket-INET6
	dev-perl/Net-SDP
	media-sound/logitechmediaserver-bin
	media-sound/shairport_helper
	net-dns/avahi
	virtual/perl-Digest-MD5
	virtual/perl-MIME-Base64
"

RDEPEND="${DEPEND}"

# or /opt/logitechmediaserver/Plugins
INSTALL_DIR="/var/lib/logitechmediaserver/Plugins/ShairTunes"

src_prepare() {
	epatch_user
}

src_install() {
	insinto ${INSTALL_DIR}
	doins AIRPLAY.pm Plugin.pm install.xml public.xml strings.txt
	fowners logitechmediaserver:logitechmediaserver ${INSTALL_DIR} -R
	dodoc README.md
}

pkg_postinst() {
	elog "ShairTunes plugin has been installed to ${INSTALL_DIR} - now:"
	elog " 1. configure/restart avahi-daemon as per avahi-daemon section in /usr/share/doc/${P}/"
	elog " 2. restart logitechmediaserver, check /var/log/logitechmediaserver/server.log"
	elog " 3. confirm services are being advertised using avahi-browse:"
	elog "       avahi-browse -tv _raop._tcp"
	elog " 4. LMS will log connections and launching decoders to /var/log/logitechmediaserver/server.log"
	elog ""
	elog "For verbose debug set: defaultLevel to DEBUG in /var/lib/logitechmediaserver/Plugins/ShairTunes/Plugin.pm"
	elog ""
	elog "Support thread at: http://forums.slimdevices.com/showthread.php?100379-Announce-ShairTunes-Plugin"
}