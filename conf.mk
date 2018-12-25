INSTALL_TARGETS += install-conf install-rc
CLEAN_TARGETS += clean-shellexrc
ALL_TARGETS += conf/shellexrc

default_confs := 10-autoexec 20-completion 20-nobeep 40-escape 40-home_end 40-setprompt 40-sigint 40-recent 90-hist 99-clear

install-conf:
	echo "[INSTALL] $@"
	$(INSTALL) -d -m 0755 $(DESTDIR)$(PREFIX)$(LIBDIR)/shellex/conf
	for file in $(wildcard conf/[0-9][0-9]-*); \
	do \
		$(INSTALL) -m 0644 $${file} $(DESTDIR)$(PREFIX)$(LIBDIR)/shellex/conf/; \
	done
	$(INSTALL) -d -m 0755 $(DESTDIR)$(SYSCONFDIR)/shellex
	for link in $(default_confs); \
	do \
		[ -e $(DESTDIR)$(SYSCONFDIR)/shellex/$${link} ] || ln -s $(PREFIX)$(LIBDIR)/shellex/conf/$${link} $(DESTDIR)$(SYSCONFDIR)/shellex; \
	done

conf/shellexrc: conf/shellexrc.in
	echo "[SED] $@"
	$(SED) $(sed_replace_vars) $< > $@

install-rc: conf/shellexrc
	echo "[INSTALL] $@"
	$(INSTALL) -d -m 0755 $(DESTDIR)$(PREFIX)$(LIBDIR)/shellex
	$(INSTALL) -m 0644 conf/shellexrc $(DESTDIR)$(PREFIX)$(LIBDIR)/shellex/shellexrc

	# $DESTDIR/$SYSCONFDIR may not exist, but if it does, don't alter the permissions
	# (this is not a shellex specific directory)
	[ -d $(DESTDIR)$(SYSCONFDIR) ] || $(INSTALL) -d -m 0755 $(DESTDIR)$(SYSCONFDIR)
	[ -e $(DESTDIR)$(SYSCONFDIR)/shellexrc ] || ln -s $(PREFIX)$(LIBDIR)/shellex/shellexrc $(DESTDIR)$(SYSCONFDIR)/shellexrc

clean-shellexrc:
	echo "[CLEAN] conf/shellexrc"
	rm -f conf/shellexrc
