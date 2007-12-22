# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_JAR_REV="r16777"
MY_JAR_FILE="freenet-${MY_JAR_REV}-snapshot.jar"

DESCRIPTION="An encrypted network without censorship"
HOMEPAGE="http://www.freenetproject.org/"
SRC_URI="http://downloads.freenetproject.org/alpha/installer/freenet07.tar.gz
	http://downloads.freenetproject.org/alpha/${MY_JAR_FILE}
	http://downloads.freenetproject.org/alpha/freenet-ext.jar"

LICENSE="GPL-2"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="!net-p2p/freenet
	>=virtual/jre-1.4"

S="${WORKDIR}/${PN/-bin/}"

QA_TEXTRELS="opt/freenet/lib/libwrapper-linux-x86-32.so"

pkg_setup() {
	enewgroup freenet
	enewuser freenet -1 -1 /opt/freenet freenet
}

src_unpack() {
	unpack "freenet07.tar.gz"
	cd "${S}"

	sed -i -e 's:./bin/wrapper:/opt/freenet/bin/wrapper:g' \
		-e 's:./wrapper.conf:/opt/freenet/wrapper.conf:g' \
		-e 's:PIDDIR=".":PIDDIR="/opt/freenet/":g' \
		-e 's:#RUN_AS_USER=:RUN_AS_USER=freenet:g' run.sh || die "sed failed"

	head -n 12 run.sh >run1.sh
	tail -n 556 run.sh >> run1.sh
	mv run1.sh run.sh
	echo "node.updater.autoupdate=false">freenet.ini
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	doinitd "${FILESDIR}"/freenet

	insinto /opt/freenet
	into /opt/freenet
	doins "${DISTDIR}/freenet-ext.jar" "${DISTDIR}/${MY_JAR_FILE}" \
		wrapper.conf run.sh freenet.ini
	dobin bin/wrapper-linux-x86-{32,64}
	dolib.so lib/libwrapper-linux-x86-{32,64}.so
	dosym freenet-stable-latest.jar /opt/freenet/freenet.jar
	fperms 755 /opt/freenet/run.sh
	fowners -R freenet:freenet /opt/freenet/
}

pkg_postinst () {
	elog "1. Start freenet with /etc/init.d/freenet start"
	elog "2. Open localhost:8888 in your browser for the web interface."
	elog " "
	elog "If you dont know trusted people running freenet,"
	elog "enable opennet ("insecure mode") on the config page to get started."

	if (diff /opt/freenet/${MY_JAR_FILE} /opt/freenet/freenet-stable-latest.jar >/dev/null 2>&1) ; then
		:;
	else
		cp /opt/freenet/${MY_JAR_FILE} /opt/freenet/freenet-stable-latest.jar
		chown freenet:freenet /opt/freenet/*jar
	fi
}

pkg_postrm() {
	elog "If you dont want to use freenet any more"
	elog "and dont want to keep your identity/other stuff"
	elog "remember to do 'rm -rf /opt/freenet' do remove everything"
}

