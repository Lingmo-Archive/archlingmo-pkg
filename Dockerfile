FROM archlinux:latest

RUN pacman-key --init && \
    pacman-key --populate archlinux && \
    pacman -Syu --noconfirm base-devel

CMD sh -c "pacman -Syu && \
    git clone --depth 1 https://github.com/LingmoOS-Testing/lingmo-arch-pkgbuilder /builder && \
    cd /builder && ./build.sh"
