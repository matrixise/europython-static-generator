EUROPYTHON=ep2017
DOMAIN=europython.eu
WEBSITE=$(EUROPYTHON).$(DOMAIN)
#
# The pattern for the website is epYEAR.europython.eu
HOST=https://$(WEBSITE)

all:
	echo "Read the README.md"

download_site:
	wget -r -c $(HOST) --no-check-certificate

download_talks:
	cat $(WEBSITE)/p3/schedule/$(EUROPYTHON)/index.html \
	    | pup "a[href^=/conference/talks] attr{href}" \
	    | sort -u | sed -e "s;^;$(HOST);" \
	    | sed -e "s;$$;.xml;" > /tmp/talks.xml.txt
	wget -i /tmp/talks.xml.txt -P $(WEBSITE)/conference/talks

clean_fonts:
	for file in $(WEBSITE)/static/p6/fonts/*\?*; do \
		mv "$$file" "$${file%%\?*}"; \
	done

remove_login:
	ack '<a href=".*">Log in</a>' $(WEBSITE) -l | xargs -n 1 sed -i -e 's;<a href=".*">Log in</a>;;'

remove_signup:
	ack '<a href=".*">Sign up</a>' $(WEBSITE) -l | xargs -n 1 sed -i -e 's;<a href=".*">Sign up</a>;;'

remove_links:
	ack "https://$(EUROPYTHON)\.europython\.eu" $(WEBSITE) --html -l | xargs -n 1 sed -i -e "s;https://$(EUROPYTHON)\.europython\.eu;;"

