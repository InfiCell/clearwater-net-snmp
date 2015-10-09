DEBIANVER := 5.7.2~dfsg
UBUNTUVER := 8.1ubuntu3.1

DEBS := libsnmp30_5.7.2~dfsg-clearwater1_amd64.deb \
        libsnmp30-dbg_5.7.2~dfsg-clearwater1_amd64.deb \
        libsnmp-base_5.7.2~dfsg-clearwater1_all.deb \
        libsnmp-dev_5.7.2~dfsg-clearwater1_amd64.deb \
        libsnmp-perl_5.7.2~dfsg-clearwater1_amd64.deb \
        python-netsnmp_5.7.2~dfsg-clearwater1_amd64.deb \
        snmp_5.7.2~dfsg-clearwater1_amd64.deb \
        snmpd_5.7.2~dfsg-clearwater1_amd64.deb \
        tkmib_5.7.2~dfsg-clearwater1_all.deb

.PHONY : all clean clean_deb_source
all : ${DEBS}
clean : clean_deb_source
	-rm ${DEBS}
clean_deb_source :
	-rm -f net-snmp_${DEBIANVER}*
	rm -rf net-snmp-${DEBIANVER}/
	-rm .*.built

${DEBS} : .clearwater1.built

.%.built : %.patch
	touch $@.tmp
	apt-get source net-snmp=${DEBIANVER}-${UBUNTUVER}
	patch -p1 < $<
	cd net-snmp-${DEBIANVER} && dpkg-buildpackage -b -us -uc -d
	${MAKE} clean_deb_source
	mv $@.tmp $@

.PHONY: print_debs
print_debs :
	@echo ${DEBS}
