# ========================================================================
# SchemaCrawler
# http://www.schemacrawler.com
# Copyright (c) 2000-2021, Sualeh Fatehi <sualeh@hotmail.com>.
# All rights reserved.
# ------------------------------------------------------------------------
#
# SchemaCrawler is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# SchemaCrawler and the accompanying materials are made available under
# the terms of the Eclipse Public License v1.0, GNU General Public License
# v3 or GNU Lesser General Public License v3.
#
# You may elect to redistribute this code under any of these licenses.
#
# The Eclipse Public License is available at:
# http://www.eclipse.org/legal/epl-v10.html
#
# The GNU General Public License v3 and the GNU Lesser General Public
# License v3 are available at:
# http://www.gnu.org/licenses/
#
# ========================================================================

FROM openjdk:11-slim-buster


ARG SCHEMACRAWLER_VERSION=16.16.3
ARG SCHEMACRAWLER_WEBAPP_VERSION=16.16.3.7

LABEL \
  "us.fatehi.schemacrawler.product-version"="SchemaCrawler ${SCHEMACRAWLER_VERSION}" \
  "us.fatehi.schemacrawler.website"="http://www.schemacrawler.com" \
  "us.fatehi.schemacrawler.docker-hub"="https://hub.docker.com/r/schemacrawler/schemacrawler"

LABEL "maintainer"="Sualeh Fatehi <sualeh@hotmail.com>"

# Install Graphviz
RUN \
    apt-get -qq update \
 && apt-get -qq -y install graphviz

# Copy SchemaCrawler Web Application files for the current user
COPY \
  ./target/schemacrawler-webapp-${SCHEMACRAWLER_WEBAPP_VERSION}.jar \
  schemacrawler-webapp.jar

# Run the web-application.  CMD is required to run on Heroku
# $JAVA_OPTS and $PORT are set by Heroku
CMD java $JAVA_OPTS -Dserver.port=$PORT -Djava.security.egd=file:/dev/./urandom -jar schemacrawler-webapp.jar
