# LaTeX environment.

FROM ubuntu:latest

ARG USER_UID=1000

ENV DEBIAN_FRONTEND=noninteractive

# Install basic utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    build-essential \
    ca-certificates \
    cpanminus \
    curl \
    git \
    gh \ 
    gnupg \
    iproute2 \
    less \
    make \
    nano \
    openssh-client \
    openssl \
    python3 \
    python3-pip \
    procps \
    software-properties-common \
    sudo \
    wget \
    emacs-intl-fonts \
    fontconfig \
    fonts-dejavu \
    fonts-dejavu-core \
    fonts-dejavu-extra \
    fonts-droid-fallback \
    fonts-liberation \
    fonts-opensymbol \
    fonts-roboto \
    fonts-roboto-hinted \
    fonts-stix \
    fonts-symbola \
    fonts-texgyre && \
    add-apt-repository universe && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*/apt/lists/*

# Install language and locales
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*/apt/lists/*
ENV LANG=en_US.UTF-8

# Install Zsh
RUN apt-get update && apt-get install -y --no-install-recommends \
    zsh \
    zsh-doc \
    chroma && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*/apt/lists/*

# Install TeX Live and various TeX utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    biber \
    cm-super \
    ghostscript \
    inkscape \
    dvipng \
    fonts-dejavu \
    fonts-dejavu-core \
    fonts-dejavu-extra \
    latexmk \
    lcdf-typetools \
    lmodern \
    pandoc \
    poppler-utils \
    psutils \
    purifyeps \
    python3-pygments \
    t1utils \
    tex-gyre \
    tex4ht \
    texlive \
    texlive-lang-italian \
    texlive-bibtex-extra \
    texlive-extra-utils \
    texlive-fonts-extra \
    texlive-font-utils \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-plain-generic \
    texlive-science && \
    rm -rf /var/lib/apt/lists/*

# Install latexindent dependencies (Perl modules)
RUN cpanm -n -q Log::Log4perl && \
    cpanm -n -q XString && \
    cpanm -n -q Log::Dispatch::File && \
    cpanm -n -q YAML::Tiny && \
    cpanm -n -q File::HomeDir && \
    cpanm -n -q Unicode::GCString
RUN wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb -P /tmp \
    && dpkg -i /tmp/lsd_0.23.1_amd64.deb \
    && rm /tmp/lsd_0.23.1_amd64.deb
# Cleanup
RUN apt-get autoremove -y && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*/apt/lists/*

# Create a non-root sudo user with Zsh as shell
RUN useradd -r -m -s /bin/bash -u ${USER_UID} docktex
ENV HOME=/home/docktex
RUN chsh -s /usr/bin/zsh docktex

# Create workspace directory: host workspaces will be mounted here
RUN mkdir ${HOME}/workspace && \
    chown docktex ${HOME}/workspace

# Create shell history file
RUN mkdir ${HOME}/zsh_history && \
    chown docktex ${HOME}/zsh_history

# Create SSH directory for user
RUN mkdir ${HOME}/.ssh

# Switch to internal user
USER docktex
WORKDIR ${HOME}

# Copy user configuration files
COPY --chown=docktex ./config/.aliases.sh ./
COPY --chown=docktex ./config/.bashrc ./
COPY --chown=docktex ./config/.nanorc ./

# Configure Zsh for internal user
ENV ZSH=${HOME}/.oh-my-zsh
ENV ZSH_CUSTOM=${ZSH}/custom
ENV ZSH_PLUGINS=${ZSH_CUSTOM}/plugins
ENV ZSH_THEMES=${ZSH_CUSTOM}/themes
RUN wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | zsh || true
RUN git clone --single-branch --branch 'master' --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_PLUGINS}/zsh-syntax-highlighting \
    && git clone --single-branch --branch 'master' --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_PLUGINS}/zsh-autosuggestions \
    && git clone --single-branch --depth 1 https://github.com/romkatv/powerlevel10k.git ${ZSH_THEMES}/powerlevel10k
COPY --chown=docktex ./config/.p10k.zsh ./
COPY --chown=docktex ./config/.zshrc ./

# Start shell in container
CMD ["zsh"]