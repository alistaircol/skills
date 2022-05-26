FROM bitnami/git:latest as font
RUN git -C /tmp clone https://github.com/googlefonts/cousine.git font

FROM nshine/dot:latest
# path inside repo with trailing slash
ARG font_path=fonts/ttf/unhinted/variable_ttf/
USER 0
RUN apk add ghostscript
RUN mkdir /usr/share/fonts/newfont
COPY --from=font /tmp/font /tmp/font
RUN find /tmp/font/$font_path -name '*.ttf' -exec install -v -m644 {} /usr/share/fonts/newfont \;
USER 1000
RUN fc-cache -v -f
CMD ["sh"]
