INSTALL_TARGETS += install-conf install-rc
CLEAN_TARGETS += clean-shellexrc
ALL_TARGETS += conf/shellexrc

default_confs := 10-autoexec 20-completion 20-nobeep 40-escape 40-home_end 40-setprompt 40-sigint 40-sudo 90-hist 99-clear

install-conf:
	echo "[INSTALL] $@"
	$(INSTALL) -d -m 0755 $(DESTDIR)$(PREFIX)$(LIBDIR)/shellex/conf
	for file in $(wildcard conf/[0-9][0-9]-*); \
	do \
		$(INSTALL) -m 0644 $${file} $(DESTDIR)$(PREFIX)$(LIBDIR)/shellex/conf/; \
	done
	# NB: no PREFIX needed between DESTDIR and SYSCONFDIR
	$(INSTALL) -d -m 0755 $(DESTDIR)$(SYSCONFDIR)/shellex
	for link in $(default_confs); \
	do \
		[ -e $(DESTDIR)$(SYSCONFDIR)/shellex/$${link} ] || ln -s $(DESTDIR)$(PREFIX)$(LIBDIR)/shellex/conf/$${link} $(DESTDIR)$(SYSCONFDIR)/shellex; \
	done

conf/shellexrc: conf/shellexrc.in
	echo "[SED] $@"
	$(SED) $(sed_replace_vars) $< > $@

install-rc: conf/shellexrc
	echo "[INSTALL] $@"
	$(INSTALL) -m 0644 conf/shellexrc $(DESTDIR)$(PREFIX)$(LIBDIR)/shellex/; \
	[ -e $(DESTDIR)$(SYSCONFDIR)/shellexrc ] || ln -s $(DESTDIR)$(PREFIX)$(LIBDIR)/shellex/shellexrc $(DESTDIR)$(SYSCONFDIR)/shellexrc

clean-shellexrc:
	echo "[CLEAN] conf/shellexrc"
	rm -f conf/shellexrc
