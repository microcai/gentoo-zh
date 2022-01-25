# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd go-module desktop xdg

DESCRIPTION="web GUI of Project V which supports V2Ray, Xray, SS, SSR, Trojan and Pingtunnel"
HOMEPAGE="https://v2raya.org/"

# sed -re 's/^(\S*) (\S*) (\S*)/"\1 \2"/g' go.sum
# echo "goproxy https://goproxy.cn/" >> /etc/portage/mirrors
EGO_SUM=(
	"cloud.google.com/go v0.26.0/go.mod"
	"cloud.google.com/go v0.31.0/go.mod"
	"cloud.google.com/go v0.34.0/go.mod"
	"cloud.google.com/go v0.37.0/go.mod"
	"cloud.google.com/go v0.38.0/go.mod"
	"cloud.google.com/go v0.44.1/go.mod"
	"cloud.google.com/go v0.44.2/go.mod"
	"cloud.google.com/go v0.45.1/go.mod"
	"cloud.google.com/go v0.46.3/go.mod"
	"cloud.google.com/go/bigquery v1.0.1/go.mod"
	"cloud.google.com/go/datastore v1.0.0/go.mod"
	"cloud.google.com/go/firestore v1.1.0/go.mod"
	"cloud.google.com/go/pubsub v1.0.1/go.mod"
	"cloud.google.com/go/storage v1.0.0/go.mod"
	"dmitri.shuralyov.com/app/changes v0.0.0-20180602232624-0a106ad413e3/go.mod"
	"dmitri.shuralyov.com/gpu/mtl v0.0.0-20190408044501-666a987793e9/go.mod"
	"dmitri.shuralyov.com/html/belt v0.0.0-20180602232347-f7d459c86be0/go.mod"
	"dmitri.shuralyov.com/service/change v0.0.0-20181023043359-a85b471d5412/go.mod"
	"dmitri.shuralyov.com/state v0.0.0-20180228185332-28bcc343414c/go.mod"
	"git.apache.org/thrift.git v0.0.0-20180902110319-2566ecd5d999/go.mod"
	"github.com/BurntSushi/toml v0.3.1"
	"github.com/BurntSushi/toml v0.3.1/go.mod"
	"github.com/BurntSushi/xgb v0.0.0-20160522181843-27f122750802/go.mod"
	"github.com/OneOfOne/xxhash v1.2.2/go.mod"
	"github.com/PuerkitoBio/goquery v1.5.1/go.mod"
	"github.com/StackExchange/wmi v1.2.1"
	"github.com/StackExchange/wmi v1.2.1/go.mod"
	"github.com/aead/chacha20 v0.0.0-20180709150244-8b13a72661da/go.mod"
	"github.com/alecthomas/template v0.0.0-20160405071501-a0175ee3bccc/go.mod"
	"github.com/alecthomas/units v0.0.0-20151022065526-2efee857e7cf/go.mod"
	"github.com/andybalholm/cascadia v1.1.0/go.mod"
	"github.com/anmitsu/go-shlex v0.0.0-20161002113705-648efa622239/go.mod"
	"github.com/antihax/optional v1.0.0/go.mod"
	"github.com/armon/circbuf v0.0.0-20150827004946-bbbad097214e/go.mod"
	"github.com/armon/go-metrics v0.0.0-20180917152333-f0300d1749da/go.mod"
	"github.com/armon/go-radix v0.0.0-20180808171621-7fddfc383310/go.mod"
	"github.com/axgle/mahonia v0.0.0-20180208002826-3358181d7394/go.mod"
	"github.com/beevik/ntp v0.3.0"
	"github.com/beevik/ntp v0.3.0/go.mod"
	"github.com/beorn7/perks v0.0.0-20180321164747-3a771d992973/go.mod"
	"github.com/beorn7/perks v1.0.0/go.mod"
	"github.com/bgentry/speakeasy v0.1.0/go.mod"
	"github.com/bketelsen/crypt v0.0.3-0.20200106085610-5cbc8cc4026c/go.mod"
	"github.com/boltdb/bolt v1.3.1"
	"github.com/boltdb/bolt v1.3.1/go.mod"
	"github.com/bradfitz/go-smtpd v0.0.0-20170404230938-deb6d6237625/go.mod"
	"github.com/buger/jsonparser v0.0.0-20181115193947-bf1c66bbce23/go.mod"
	"github.com/census-instrumentation/opencensus-proto v0.2.1/go.mod"
	"github.com/cespare/xxhash v1.1.0/go.mod"
	"github.com/cheekybits/genny v1.0.0"
	"github.com/cheekybits/genny v1.0.0/go.mod"
	"github.com/chzyer/logex v1.1.10/go.mod"
	"github.com/chzyer/readline v0.0.0-20180603132655-2972be24d48e/go.mod"
	"github.com/chzyer/test v0.0.0-20180213035817-a1ea475d72b1/go.mod"
	"github.com/client9/misspell v0.3.4/go.mod"
	"github.com/cncf/udpa/go v0.0.0-20191209042840-269d4d468f6f/go.mod"
	"github.com/cncf/udpa/go v0.0.0-20201120205902-5459f2c99403/go.mod"
	"github.com/cncf/xds/go v0.0.0-20210312221358-fbca930ec8ed/go.mod"
	"github.com/coreos/bbolt v1.3.2/go.mod"
	"github.com/coreos/etcd v3.3.13+incompatible/go.mod"
	"github.com/coreos/go-semver v0.3.0/go.mod"
	"github.com/coreos/go-systemd v0.0.0-20181012123002-c6f51f82210d/go.mod"
	"github.com/coreos/go-systemd v0.0.0-20190321100706-95778dfbb74e/go.mod"
	"github.com/coreos/pkg v0.0.0-20180928190104-399ea9e2e55f/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.0/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/devfeel/mapper v0.7.5"
	"github.com/devfeel/mapper v0.7.5/go.mod"
	"github.com/dgrijalva/jwt-go v3.2.0+incompatible"
	"github.com/dgrijalva/jwt-go v3.2.0+incompatible/go.mod"
	"github.com/dgrijalva/jwt-go/v4 v4.0.0-preview1"
	"github.com/dgrijalva/jwt-go/v4 v4.0.0-preview1/go.mod"
	"github.com/dgryski/go-camellia v0.0.0-20191119043421-69a8a13fb23d"
	"github.com/dgryski/go-camellia v0.0.0-20191119043421-69a8a13fb23d/go.mod"
	"github.com/dgryski/go-idea v0.0.0-20170306091226-d2fb45a411fb"
	"github.com/dgryski/go-idea v0.0.0-20170306091226-d2fb45a411fb/go.mod"
	"github.com/dgryski/go-metro v0.0.0-20200812162917-85c65e2d0165"
	"github.com/dgryski/go-metro v0.0.0-20200812162917-85c65e2d0165/go.mod"
	"github.com/dgryski/go-rc2 v0.0.0-20150621095337-8a9021637152"
	"github.com/dgryski/go-rc2 v0.0.0-20150621095337-8a9021637152/go.mod"
	"github.com/dgryski/go-sip13 v0.0.0-20181026042036-e10d5fee7954/go.mod"
	"github.com/dustin/go-humanize v1.0.0/go.mod"
	"github.com/ebfe/bcrypt_pbkdf v0.0.0-20140212075826-3c8d2dcb253a"
	"github.com/ebfe/bcrypt_pbkdf v0.0.0-20140212075826-3c8d2dcb253a/go.mod"
	"github.com/ebfe/rc2 v0.0.0-20131011165748-24b9757f5521"
	"github.com/ebfe/rc2 v0.0.0-20131011165748-24b9757f5521/go.mod"
	"github.com/envoyproxy/go-control-plane v0.9.0/go.mod"
	"github.com/envoyproxy/go-control-plane v0.9.1-0.20191026205805-5f8ba28d4473/go.mod"
	"github.com/envoyproxy/go-control-plane v0.9.4/go.mod"
	"github.com/envoyproxy/go-control-plane v0.9.9-0.20201210154907-fd9021fe5dad/go.mod"
	"github.com/envoyproxy/go-control-plane v0.9.9-0.20210512163311-63b5d3c536b0/go.mod"
	"github.com/envoyproxy/protoc-gen-validate v0.1.0/go.mod"
	"github.com/fanliao/go-promise v0.0.0-20141029170127-1890db352a72/go.mod"
	"github.com/fatih/color v1.7.0/go.mod"
	"github.com/flynn/go-shlex v0.0.0-20150515145356-3f9db97f8568/go.mod"
	"github.com/francoispqt/gojay v1.2.13/go.mod"
	"github.com/fsnotify/fsnotify v1.4.7/go.mod"
	"github.com/fsnotify/fsnotify v1.4.9"
	"github.com/fsnotify/fsnotify v1.4.9/go.mod"
	"github.com/ghodss/yaml v1.0.0/go.mod"
	"github.com/gin-contrib/cors v1.3.1"
	"github.com/gin-contrib/cors v1.3.1/go.mod"
	"github.com/gin-contrib/gzip v0.0.3"
	"github.com/gin-contrib/gzip v0.0.3/go.mod"
	"github.com/gin-contrib/sse v0.1.0"
	"github.com/gin-contrib/sse v0.1.0/go.mod"
	"github.com/gin-gonic/gin v1.5.0/go.mod"
	"github.com/gin-gonic/gin v1.6.3/go.mod"
	"github.com/gin-gonic/gin v1.7.1"
	"github.com/gin-gonic/gin v1.7.1/go.mod"
	"github.com/gliderlabs/ssh v0.1.1/go.mod"
	"github.com/go-errors/errors v1.0.1/go.mod"
	"github.com/go-gl/glfw v0.0.0-20190409004039-e6da0acd62b1/go.mod"
	"github.com/go-kit/kit v0.8.0/go.mod"
	"github.com/go-logfmt/logfmt v0.3.0/go.mod"
	"github.com/go-logfmt/logfmt v0.4.0/go.mod"
	"github.com/go-ole/go-ole v0.0.0-20210915003542-8b1f7f90f6b1"
	"github.com/go-ole/go-ole v0.0.0-20210915003542-8b1f7f90f6b1/go.mod"
	"github.com/go-playground/assert/v2 v2.0.1"
	"github.com/go-playground/assert/v2 v2.0.1/go.mod"
	"github.com/go-playground/locales v0.12.1/go.mod"
	"github.com/go-playground/locales v0.13.0"
	"github.com/go-playground/locales v0.13.0/go.mod"
	"github.com/go-playground/universal-translator v0.16.0/go.mod"
	"github.com/go-playground/universal-translator v0.17.0"
	"github.com/go-playground/universal-translator v0.17.0/go.mod"
	"github.com/go-playground/validator/v10 v10.2.0/go.mod"
	"github.com/go-playground/validator/v10 v10.4.1"
	"github.com/go-playground/validator/v10 v10.4.1/go.mod"
	"github.com/go-sql-driver/mysql v1.5.0/go.mod"
	"github.com/go-stack/stack v1.8.0/go.mod"
	"github.com/go-task/slim-sprig v0.0.0-20210107165309-348f09dbbbc0"
	"github.com/go-task/slim-sprig v0.0.0-20210107165309-348f09dbbbc0/go.mod"
	"github.com/gocarina/gocsv v0.0.0-20201103164230-b291445e0dd2/go.mod"
	"github.com/gocarina/gocsv v0.0.0-20210408192840-02d7211d929d"
	"github.com/gocarina/gocsv v0.0.0-20210408192840-02d7211d929d/go.mod"
	"github.com/gogo/protobuf v1.1.1/go.mod"
	"github.com/gogo/protobuf v1.2.1/go.mod"
	"github.com/golang/glog v0.0.0-20160126235308-23def4e6c14b/go.mod"
	"github.com/golang/groupcache v0.0.0-20190129154638-5b532d6fd5ef/go.mod"
	"github.com/golang/lint v0.0.0-20180702182130-06c8688daad7/go.mod"
	"github.com/golang/mock v1.1.1/go.mod"
	"github.com/golang/mock v1.2.0/go.mod"
	"github.com/golang/mock v1.3.1/go.mod"
	"github.com/golang/mock v1.4.4/go.mod"
	"github.com/golang/mock v1.6.0"
	"github.com/golang/mock v1.6.0/go.mod"
	"github.com/golang/protobuf v1.2.0/go.mod"
	"github.com/golang/protobuf v1.3.1/go.mod"
	"github.com/golang/protobuf v1.3.2/go.mod"
	"github.com/golang/protobuf v1.3.3/go.mod"
	"github.com/golang/protobuf v1.4.0-rc.1/go.mod"
	"github.com/golang/protobuf v1.4.0-rc.1.0.20200221234624-67d41d38c208/go.mod"
	"github.com/golang/protobuf v1.4.0-rc.2/go.mod"
	"github.com/golang/protobuf v1.4.0-rc.4.0.20200313231945-b860323f09d0/go.mod"
	"github.com/golang/protobuf v1.4.0/go.mod"
	"github.com/golang/protobuf v1.4.1/go.mod"
	"github.com/golang/protobuf v1.4.2/go.mod"
	"github.com/golang/protobuf v1.4.3/go.mod"
	"github.com/golang/protobuf v1.5.0/go.mod"
	"github.com/golang/protobuf v1.5.2"
	"github.com/golang/protobuf v1.5.2/go.mod"
	"github.com/google/btree v0.0.0-20180813153112-4030bb1f1f0c/go.mod"
	"github.com/google/btree v1.0.0/go.mod"
	"github.com/google/go-cmp v0.2.0/go.mod"
	"github.com/google/go-cmp v0.3.0/go.mod"
	"github.com/google/go-cmp v0.3.1/go.mod"
	"github.com/google/go-cmp v0.4.0/go.mod"
	"github.com/google/go-cmp v0.5.0/go.mod"
	"github.com/google/go-cmp v0.5.1/go.mod"
	"github.com/google/go-cmp v0.5.2/go.mod"
	"github.com/google/go-cmp v0.5.5/go.mod"
	"github.com/google/go-cmp v0.5.6"
	"github.com/google/go-cmp v0.5.6/go.mod"
	"github.com/google/go-github v17.0.0+incompatible/go.mod"
	"github.com/google/go-querystring v1.0.0/go.mod"
	"github.com/google/gofuzz v1.0.0/go.mod"
	"github.com/google/gopacket v1.1.19"
	"github.com/google/gopacket v1.1.19/go.mod"
	"github.com/google/martian v2.1.0+incompatible/go.mod"
	"github.com/google/pprof v0.0.0-20181206194817-3ea8567a2e57/go.mod"
	"github.com/google/pprof v0.0.0-20190515194954-54271f7e092f/go.mod"
	"github.com/google/renameio v0.1.0/go.mod"
	"github.com/google/uuid v1.1.1/go.mod"
	"github.com/google/uuid v1.1.2"
	"github.com/google/uuid v1.1.2/go.mod"
	"github.com/googleapis/gax-go v2.0.0+incompatible/go.mod"
	"github.com/googleapis/gax-go/v2 v2.0.3/go.mod"
	"github.com/googleapis/gax-go/v2 v2.0.4/go.mod"
	"github.com/googleapis/gax-go/v2 v2.0.5/go.mod"
	"github.com/gopherjs/gopherjs v0.0.0-20181017120253-0766667cb4d1/go.mod"
	"github.com/gopherjs/gopherjs v0.0.0-20210420193930-a4630ec28c79/go.mod"
	"github.com/gopherjs/websocket v0.0.0-20191103002815-9a42957e2b3a/go.mod"
	"github.com/gordonklaus/ineffassign v0.0.0-20200309095847-7953dde2c7bf/go.mod"
	"github.com/gorilla/websocket v1.4.2"
	"github.com/gorilla/websocket v1.4.2/go.mod"
	"github.com/gregjones/httpcache v0.0.0-20180305231024-9cad4c3443a7/go.mod"
	"github.com/grpc-ecosystem/go-grpc-middleware v1.0.0/go.mod"
	"github.com/grpc-ecosystem/go-grpc-prometheus v1.2.0/go.mod"
	"github.com/grpc-ecosystem/grpc-gateway v1.5.0/go.mod"
	"github.com/grpc-ecosystem/grpc-gateway v1.9.0/go.mod"
	"github.com/grpc-ecosystem/grpc-gateway v1.16.0/go.mod"
	"github.com/h12w/go-socks5 v0.0.0-20200522160539-76189e178364/go.mod"
	"github.com/hashicorp/consul/api v1.1.0/go.mod"
	"github.com/hashicorp/consul/sdk v0.1.1/go.mod"
	"github.com/hashicorp/errwrap v1.0.0/go.mod"
	"github.com/hashicorp/go-cleanhttp v0.5.1/go.mod"
	"github.com/hashicorp/go-immutable-radix v1.0.0/go.mod"
	"github.com/hashicorp/go-msgpack v0.5.3/go.mod"
	"github.com/hashicorp/go-multierror v1.0.0/go.mod"
	"github.com/hashicorp/go-rootcerts v1.0.0/go.mod"
	"github.com/hashicorp/go-sockaddr v1.0.0/go.mod"
	"github.com/hashicorp/go-syslog v1.0.0/go.mod"
	"github.com/hashicorp/go-uuid v1.0.0/go.mod"
	"github.com/hashicorp/go-uuid v1.0.1/go.mod"
	"github.com/hashicorp/go.net v0.0.1/go.mod"
	"github.com/hashicorp/golang-lru v0.5.0/go.mod"
	"github.com/hashicorp/golang-lru v0.5.1/go.mod"
	"github.com/hashicorp/hcl v1.0.0/go.mod"
	"github.com/hashicorp/logutils v1.0.0/go.mod"
	"github.com/hashicorp/mdns v1.0.0/go.mod"
	"github.com/hashicorp/memberlist v0.1.3/go.mod"
	"github.com/hashicorp/serf v0.8.2/go.mod"
	"github.com/hpcloud/tail v1.0.0/go.mod"
	"github.com/hugelgupf/socketpair v0.0.0-20190730060125-05d35a94e714/go.mod"
	"github.com/inconshreveable/mousetrap v1.0.0/go.mod"
	"github.com/insomniacslk/dhcp v0.0.0-20201112113307-4de412bc85d8/go.mod"
	"github.com/jellevandenhooff/dkim v0.0.0-20150330215556-f50fe3d243e1/go.mod"
	"github.com/jhump/protoreflect v1.9.0"
	"github.com/jhump/protoreflect v1.9.0/go.mod"
	"github.com/jonboulle/clockwork v0.1.0/go.mod"
	"github.com/jsimonetti/rtnetlink v0.0.0-20190606172950-9527aa82566a/go.mod"
	"github.com/jsimonetti/rtnetlink v0.0.0-20200117123717-f846d4f6c1f4/go.mod"
	"github.com/jsimonetti/rtnetlink v0.0.0-20201009170750-9c6f07d100c1/go.mod"
	"github.com/jsimonetti/rtnetlink v0.0.0-20201110080708-d2c240429e6c/go.mod"
	"github.com/json-iterator/go v1.1.6/go.mod"
	"github.com/json-iterator/go v1.1.7/go.mod"
	"github.com/json-iterator/go v1.1.9/go.mod"
	"github.com/json-iterator/go v1.1.11"
	"github.com/json-iterator/go v1.1.11/go.mod"
	"github.com/jstemmer/go-junit-report v0.0.0-20190106144839-af01ea7f8024/go.mod"
	"github.com/jtolds/gls v4.20.0+incompatible/go.mod"
	"github.com/julienschmidt/httprouter v1.2.0/go.mod"
	"github.com/kisielk/errcheck v1.1.0/go.mod"
	"github.com/kisielk/gotool v1.0.0/go.mod"
	"github.com/klauspost/cpuid v1.2.4/go.mod"
	"github.com/klauspost/cpuid v1.3.1/go.mod"
	"github.com/klauspost/reedsolomon v1.9.9/go.mod"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.1/go.mod"
	"github.com/kr/logfmt v0.0.0-20140226030751-b84e30acd515/go.mod"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pretty v0.2.1"
	"github.com/kr/pretty v0.2.1/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/pty v1.1.3/go.mod"
	"github.com/kr/text v0.1.0"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/leodido/go-urn v1.1.0/go.mod"
	"github.com/leodido/go-urn v1.2.0"
	"github.com/leodido/go-urn v1.2.0/go.mod"
	"github.com/lucas-clemente/quic-go v0.23.0"
	"github.com/lucas-clemente/quic-go v0.23.0/go.mod"
	"github.com/lunixbochs/struc v0.0.0-20200707160740-784aaebc1d40"
	"github.com/lunixbochs/struc v0.0.0-20200707160740-784aaebc1d40/go.mod"
	"github.com/lunixbochs/vtclean v1.0.0/go.mod"
	"github.com/magiconair/properties v1.8.1/go.mod"
	"github.com/mailru/easyjson v0.0.0-20190312143242-1de009706dbe/go.mod"
	"github.com/marten-seemann/qpack v0.2.1/go.mod"
	"github.com/marten-seemann/qtls-go1-15 v0.1.4/go.mod"
	"github.com/marten-seemann/qtls-go1-16 v0.1.4"
	"github.com/marten-seemann/qtls-go1-16 v0.1.4/go.mod"
	"github.com/marten-seemann/qtls-go1-17 v0.1.0"
	"github.com/marten-seemann/qtls-go1-17 v0.1.0/go.mod"
	"github.com/matoous/go-nanoid v1.5.0"
	"github.com/matoous/go-nanoid v1.5.0/go.mod"
	"github.com/mattn/go-colorable v0.0.9/go.mod"
	"github.com/mattn/go-isatty v0.0.3/go.mod"
	"github.com/mattn/go-isatty v0.0.9/go.mod"
	"github.com/mattn/go-isatty v0.0.12"
	"github.com/mattn/go-isatty v0.0.12/go.mod"
	"github.com/mattn/go-sqlite3 v2.0.3+incompatible/go.mod"
	"github.com/matttproud/golang_protobuf_extensions v1.0.1/go.mod"
	"github.com/mdlayher/ethernet v0.0.0-20190606142754-0394541c37b7/go.mod"
	"github.com/mdlayher/netlink v0.0.0-20190409211403-11939a169225/go.mod"
	"github.com/mdlayher/netlink v1.0.0/go.mod"
	"github.com/mdlayher/netlink v1.1.0/go.mod"
	"github.com/mdlayher/netlink v1.1.1/go.mod"
	"github.com/mdlayher/raw v0.0.0-20190606142536-fef19f00fc18/go.mod"
	"github.com/mdlayher/raw v0.0.0-20191009151244-50f2db8cc065/go.mod"
	"github.com/microcosm-cc/bluemonday v1.0.1/go.mod"
	"github.com/miekg/dns v1.0.14/go.mod"
	"github.com/miekg/dns v1.1.43/go.mod"
	"github.com/mitchellh/cli v1.0.0/go.mod"
	"github.com/mitchellh/go-homedir v1.0.0/go.mod"
	"github.com/mitchellh/go-homedir v1.1.0/go.mod"
	"github.com/mitchellh/go-testing-interface v1.0.0/go.mod"
	"github.com/mitchellh/gox v0.4.0/go.mod"
	"github.com/mitchellh/iochan v1.0.0/go.mod"
	"github.com/mitchellh/mapstructure v0.0.0-20160808181253-ca63d7c062ee/go.mod"
	"github.com/mitchellh/mapstructure v1.1.2/go.mod"
	"github.com/mmcloughlin/avo v0.0.0-20200803215136-443f81d77104/go.mod"
	"github.com/mmcloughlin/avo v0.0.0-20201130012700-45c8ae10fd12/go.mod"
	"github.com/modern-go/concurrent v0.0.0-20180228061459-e0a39a4cb421/go.mod"
	"github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd"
	"github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd/go.mod"
	"github.com/modern-go/reflect2 v0.0.0-20180701023420-4b7aa43c6742/go.mod"
	"github.com/modern-go/reflect2 v1.0.1"
	"github.com/modern-go/reflect2 v1.0.1/go.mod"
	"github.com/mohae/deepcopy v0.0.0-20170929034955-c48cc78d4826"
	"github.com/mohae/deepcopy v0.0.0-20170929034955-c48cc78d4826/go.mod"
	"github.com/muhammadmuzzammil1998/jsonc v0.0.0-20201229145248-615b0916ca38"
	"github.com/muhammadmuzzammil1998/jsonc v0.0.0-20201229145248-615b0916ca38/go.mod"
	"github.com/mwitkow/go-conntrack v0.0.0-20161129095857-cc309e4a2223/go.mod"
	"github.com/mzz2017/go-engine v0.0.0-20200509094339-b56921189229"
	"github.com/mzz2017/go-engine v0.0.0-20200509094339-b56921189229/go.mod"
	"github.com/nadoo/conflag v0.2.3/go.mod"
	"github.com/nadoo/glider v0.13.0/go.mod"
	"github.com/nadoo/ipset v0.3.0/go.mod"
	"github.com/neelance/astrewrite v0.0.0-20160511093645-99348263ae86/go.mod"
	"github.com/neelance/sourcemap v0.0.0-20151028013722-8c68805598ab/go.mod"
	"github.com/neelance/sourcemap v0.0.0-20200213170602-2833bce08e4c/go.mod"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e/go.mod"
	"github.com/nishanths/predeclared v0.0.0-20200524104333-86fad755b4d3/go.mod"
	"github.com/nxadm/tail v1.4.4/go.mod"
	"github.com/nxadm/tail v1.4.8"
	"github.com/nxadm/tail v1.4.8/go.mod"
	"github.com/oklog/ulid v1.3.1/go.mod"
	"github.com/onsi/ginkgo v1.6.0/go.mod"
	"github.com/onsi/ginkgo v1.12.1/go.mod"
	"github.com/onsi/ginkgo v1.14.0/go.mod"
	"github.com/onsi/ginkgo v1.16.2/go.mod"
	"github.com/onsi/ginkgo v1.16.4"
	"github.com/onsi/ginkgo v1.16.4/go.mod"
	"github.com/onsi/gomega v1.7.1/go.mod"
	"github.com/onsi/gomega v1.10.1/go.mod"
	"github.com/onsi/gomega v1.13.0/go.mod"
	"github.com/openzipkin/zipkin-go v0.1.1/go.mod"
	"github.com/oschwald/geoip2-golang v1.4.0/go.mod"
	"github.com/oschwald/maxminddb-golang v1.6.0/go.mod"
	"github.com/pascaldekloe/goe v0.0.0-20180627143212-57f6aae5913c/go.mod"
	"github.com/pelletier/go-toml v1.2.0"
	"github.com/pelletier/go-toml v1.2.0/go.mod"
	"github.com/phayes/freeport v0.0.0-20180830031419-95f893ade6f2/go.mod"
	"github.com/pires/go-proxyproto v0.6.0"
	"github.com/pires/go-proxyproto v0.6.0/go.mod"
	"github.com/pkg/errors v0.8.0/go.mod"
	"github.com/pkg/errors v0.8.1/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/posener/complete v1.1.1/go.mod"
	"github.com/prometheus/client_golang v0.8.0/go.mod"
	"github.com/prometheus/client_golang v0.9.1/go.mod"
	"github.com/prometheus/client_golang v0.9.3/go.mod"
	"github.com/prometheus/client_model v0.0.0-20180712105110-5c3871d89910/go.mod"
	"github.com/prometheus/client_model v0.0.0-20190129233127-fd36f4220a90/go.mod"
	"github.com/prometheus/client_model v0.0.0-20190812154241-14fe0d1b01d4/go.mod"
	"github.com/prometheus/common v0.0.0-20180801064454-c7de2306084e/go.mod"
	"github.com/prometheus/common v0.0.0-20181113130724-41aa239b4cce/go.mod"
	"github.com/prometheus/common v0.4.0/go.mod"
	"github.com/prometheus/procfs v0.0.0-20180725123919-05ee40e3a273/go.mod"
	"github.com/prometheus/procfs v0.0.0-20181005140218-185b4288413d/go.mod"
	"github.com/prometheus/procfs v0.0.0-20190507164030-5867b95ac084/go.mod"
	"github.com/prometheus/tsdb v0.7.1/go.mod"
	"github.com/riobard/go-bloom v0.0.0-20200614022211-cdc8013cb5b3"
	"github.com/riobard/go-bloom v0.0.0-20200614022211-cdc8013cb5b3/go.mod"
	"github.com/rogpeppe/fastuuid v0.0.0-20150106093220-6724a57986af/go.mod"
	"github.com/rogpeppe/fastuuid v1.2.0/go.mod"
	"github.com/rogpeppe/go-internal v1.3.0/go.mod"
	"github.com/russross/blackfriday v1.5.2/go.mod"
	"github.com/russross/blackfriday/v2 v2.0.1/go.mod"
	"github.com/ryanuber/columnize v0.0.0-20160712163229-9b3edd62028f/go.mod"
	"github.com/sean-/seed v0.0.0-20170313163322-e2103e2c3529/go.mod"
	"github.com/seiflotfy/cuckoofilter v0.0.0-20201222105146-bc6005554a0c"
	"github.com/seiflotfy/cuckoofilter v0.0.0-20201222105146-bc6005554a0c/go.mod"
	"github.com/sergi/go-diff v1.0.0/go.mod"
	"github.com/shadowsocks/go-shadowsocks2 v0.1.5-0.20210421162817-acdbac05f5a5"
	"github.com/shadowsocks/go-shadowsocks2 v0.1.5-0.20210421162817-acdbac05f5a5/go.mod"
	"github.com/shiena/ansicolor v0.0.0-20200904210342-c7312218db18"
	"github.com/shiena/ansicolor v0.0.0-20200904210342-c7312218db18/go.mod"
	"github.com/shirou/gopsutil v0.0.0-20210919144451-80d5b574053f"
	"github.com/shirou/gopsutil v0.0.0-20210919144451-80d5b574053f/go.mod"
	"github.com/shirou/gopsutil v3.21.8+incompatible"
	"github.com/shirou/gopsutil v3.21.8+incompatible/go.mod"
	"github.com/shiyanhui/dht v0.0.0-20190320084728-1b3b78ecf279/go.mod"
	"github.com/shurcooL/component v0.0.0-20170202220835-f88ec8f54cc4/go.mod"
	"github.com/shurcooL/events v0.0.0-20181021180414-410e4ca65f48/go.mod"
	"github.com/shurcooL/github_flavored_markdown v0.0.0-20181002035957-2122de532470/go.mod"
	"github.com/shurcooL/go v0.0.0-20180423040247-9e1955d9fb6e/go.mod"
	"github.com/shurcooL/go v0.0.0-20200502201357-93f07166e636/go.mod"
	"github.com/shurcooL/go-goon v0.0.0-20170922171312-37c2f522c041/go.mod"
	"github.com/shurcooL/gofontwoff v0.0.0-20180329035133-29b52fc0a18d/go.mod"
	"github.com/shurcooL/gopherjslib v0.0.0-20160914041154-feb6d3990c2c/go.mod"
	"github.com/shurcooL/highlight_diff v0.0.0-20170515013008-09bb4053de1b/go.mod"
	"github.com/shurcooL/highlight_go v0.0.0-20181028180052-98c3abbbae20/go.mod"
	"github.com/shurcooL/home v0.0.0-20181020052607-80b7ffcb30f9/go.mod"
	"github.com/shurcooL/htmlg v0.0.0-20170918183704-d01228ac9e50/go.mod"
	"github.com/shurcooL/httperror v0.0.0-20170206035902-86b7830d14cc/go.mod"
	"github.com/shurcooL/httpfs v0.0.0-20171119174359-809beceb2371/go.mod"
	"github.com/shurcooL/httpfs v0.0.0-20190707220628-8d4bc4ba7749/go.mod"
	"github.com/shurcooL/httpgzip v0.0.0-20180522190206-b1c53ac65af9/go.mod"
	"github.com/shurcooL/issues v0.0.0-20181008053335-6292fdc1e191/go.mod"
	"github.com/shurcooL/issuesapp v0.0.0-20180602232740-048589ce2241/go.mod"
	"github.com/shurcooL/notifications v0.0.0-20181007000457-627ab5aea122/go.mod"
	"github.com/shurcooL/octicon v0.0.0-20181028054416-fa4f57f9efb2/go.mod"
	"github.com/shurcooL/reactions v0.0.0-20181006231557-f2e0b4ca5b82/go.mod"
	"github.com/shurcooL/sanitized_anchor_name v0.0.0-20170918181015-86672fcb3f95/go.mod"
	"github.com/shurcooL/sanitized_anchor_name v1.0.0/go.mod"
	"github.com/shurcooL/users v0.0.0-20180125191416-49c67e49c537/go.mod"
	"github.com/shurcooL/webdavfs v0.0.0-20170829043945-18c3829fa133/go.mod"
	"github.com/sirupsen/logrus v1.2.0/go.mod"
	"github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d/go.mod"
	"github.com/smartystreets/goconvey v1.6.4/go.mod"
	"github.com/soheilhy/cmux v0.1.4/go.mod"
	"github.com/sourcegraph/annotate v0.0.0-20160123013949-f4cad6c6324d/go.mod"
	"github.com/sourcegraph/syntaxhighlight v0.0.0-20170531221838-bd320f5d308e/go.mod"
	"github.com/spaolacci/murmur3 v0.0.0-20180118202830-f09979ecbc72/go.mod"
	"github.com/spf13/afero v1.1.2/go.mod"
	"github.com/spf13/cast v1.3.0/go.mod"
	"github.com/spf13/cobra v1.1.3/go.mod"
	"github.com/spf13/jwalterweatherman v1.0.0/go.mod"
	"github.com/spf13/pflag v1.0.3/go.mod"
	"github.com/spf13/pflag v1.0.5/go.mod"
	"github.com/spf13/viper v1.7.0/go.mod"
	"github.com/stevenroose/gonfig v0.1.5"
	"github.com/stevenroose/gonfig v0.1.5/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.1.1/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/stretchr/testify v1.5.1/go.mod"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/subosito/gotenv v1.2.0/go.mod"
	"github.com/tarm/serial v0.0.0-20180830185346-98f6abe2eb07/go.mod"
	"github.com/templexxx/cpu v0.0.1/go.mod"
	"github.com/templexxx/cpu v0.0.7/go.mod"
	"github.com/templexxx/xorsimd v0.4.1/go.mod"
	"github.com/tidwall/gjson v1.10.2"
	"github.com/tidwall/gjson v1.10.2/go.mod"
	"github.com/tidwall/match v1.1.1"
	"github.com/tidwall/match v1.1.1/go.mod"
	"github.com/tidwall/pretty v1.2.0"
	"github.com/tidwall/pretty v1.2.0/go.mod"
	"github.com/tidwall/sjson v1.2.3"
	"github.com/tidwall/sjson v1.2.3/go.mod"
	"github.com/tjfoc/gmsm v1.3.2/go.mod"
	"github.com/tmc/grpc-websocket-proxy v0.0.0-20190109142713-0ad062ec5ee5/go.mod"
	"github.com/u-root/u-root v7.0.0+incompatible/go.mod"
	"github.com/ugorji/go v1.1.7"
	"github.com/ugorji/go v1.1.7/go.mod"
	"github.com/ugorji/go/codec v1.1.7"
	"github.com/ugorji/go/codec v1.1.7/go.mod"
	"github.com/v2fly/BrowserBridge v0.0.0-20210430233438-0570fc1d7d08"
	"github.com/v2fly/BrowserBridge v0.0.0-20210430233438-0570fc1d7d08/go.mod"
	"github.com/v2fly/VSign v0.0.0-20201108000810-e2adc24bf848"
	"github.com/v2fly/VSign v0.0.0-20201108000810-e2adc24bf848/go.mod"
	"github.com/v2fly/ss-bloomring v0.0.0-20210312155135-28617310f63e"
	"github.com/v2fly/ss-bloomring v0.0.0-20210312155135-28617310f63e/go.mod"
	"github.com/v2fly/v2ray-core/v4 v4.42.1"
	"github.com/v2fly/v2ray-core/v4 v4.42.1/go.mod"
	"github.com/v2rayA/RoutingA v1.0.0"
	"github.com/v2rayA/RoutingA v1.0.0/go.mod"
	"github.com/v2rayA/beego/v2 v2.0.4"
	"github.com/v2rayA/beego/v2 v2.0.4/go.mod"
	"github.com/v2rayA/go-uci v0.0.0-20210907104827-4cf744297b41"
	"github.com/v2rayA/go-uci v0.0.0-20210907104827-4cf744297b41/go.mod"
	"github.com/v2rayA/shadowsocksR v1.0.3"
	"github.com/v2rayA/shadowsocksR v1.0.3/go.mod"
	"github.com/viant/assertly v0.4.8/go.mod"
	"github.com/viant/toolbox v0.24.0/go.mod"
	"github.com/xiang90/probing v0.0.0-20190116061207-43a291ad63a2/go.mod"
	"github.com/xtaci/kcp-go/v5 v5.6.1/go.mod"
	"github.com/xtaci/lossyconn v0.0.0-20190602105132-8df528c0c9ae/go.mod"
	"github.com/xtaci/smux v1.5.15"
	"github.com/xtaci/smux v1.5.15/go.mod"
	"github.com/yuin/goldmark v1.1.27/go.mod"
	"github.com/yuin/goldmark v1.1.32/go.mod"
	"github.com/yuin/goldmark v1.2.1/go.mod"
	"github.com/yuin/goldmark v1.3.5/go.mod"
	"gitlab.com/yawning/chacha20.git v0.0.0-20190903091407-6d1cb28dc72c"
	"gitlab.com/yawning/chacha20.git v0.0.0-20190903091407-6d1cb28dc72c/go.mod"
	"go.etcd.io/bbolt v1.3.2/go.mod"
	"go.opencensus.io v0.18.0/go.mod"
	"go.opencensus.io v0.21.0/go.mod"
	"go.opencensus.io v0.22.0/go.mod"
	"go.opentelemetry.io/proto/otlp v0.7.0/go.mod"
	"go.starlark.net v0.0.0-20210602144842-1cdb82c9e17a"
	"go.starlark.net v0.0.0-20210602144842-1cdb82c9e17a/go.mod"
	"go.uber.org/atomic v1.4.0/go.mod"
	"go.uber.org/multierr v1.1.0/go.mod"
	"go.uber.org/zap v1.10.0/go.mod"
	"go4.org v0.0.0-20180809161055-417644f6feb5/go.mod"
	"golang.org/x/arch v0.0.0-20190909030613-46d78d1859ac/go.mod"
	"golang.org/x/arch v0.0.0-20201008161808-52c3e6f60cff/go.mod"
	"golang.org/x/build v0.0.0-20190111050920-041ab4dc3f9d/go.mod"
	"golang.org/x/crypto v0.0.0-20180904163835-0709b304e793/go.mod"
	"golang.org/x/crypto v0.0.0-20181029021203-45a5f77698d3/go.mod"
	"golang.org/x/crypto v0.0.0-20181030102418-4d3f4d9ffa16/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20190313024323-a1f597ede03a/go.mod"
	"golang.org/x/crypto v0.0.0-20190510104115-cbcb75029529/go.mod"
	"golang.org/x/crypto v0.0.0-20190605123033-f99c8df09eb5/go.mod"
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod"
	"golang.org/x/crypto v0.0.0-20191219195013-becbf705a915/go.mod"
	"golang.org/x/crypto v0.0.0-20200221231518-2aa609cf4a9d/go.mod"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
	"golang.org/x/crypto v0.0.0-20200728195943-123391ffb6de/go.mod"
	"golang.org/x/crypto v0.0.0-20201203163018-be400aefbc4c/go.mod"
	"golang.org/x/crypto v0.0.0-20210220033148-5ea612d1eb83/go.mod"
	"golang.org/x/crypto v0.0.0-20210322153248-0c34fe9e7dc2/go.mod"
	"golang.org/x/crypto v0.0.0-20210817164053-32db794688a5"
	"golang.org/x/crypto v0.0.0-20210817164053-32db794688a5/go.mod"
	"golang.org/x/exp v0.0.0-20190121172915-509febef88a4/go.mod"
	"golang.org/x/exp v0.0.0-20190306152737-a1d7652674e8/go.mod"
	"golang.org/x/exp v0.0.0-20190510132918-efd6b22b2522/go.mod"
	"golang.org/x/exp v0.0.0-20190829153037-c13cbed26979/go.mod"
	"golang.org/x/exp v0.0.0-20191030013958-a1ab85dbe136/go.mod"
	"golang.org/x/image v0.0.0-20190227222117-0694c2d4d067/go.mod"
	"golang.org/x/image v0.0.0-20190802002840-cff245a6509b/go.mod"
	"golang.org/x/lint v0.0.0-20180702182130-06c8688daad7/go.mod"
	"golang.org/x/lint v0.0.0-20181026193005-c67002cb31c3/go.mod"
	"golang.org/x/lint v0.0.0-20190227174305-5b3e6a55c961/go.mod"
	"golang.org/x/lint v0.0.0-20190301231843-5614ed5bae6f/go.mod"
	"golang.org/x/lint v0.0.0-20190313153728-d0100b6bd8b3/go.mod"
	"golang.org/x/lint v0.0.0-20190409202823-959b441ac422/go.mod"
	"golang.org/x/lint v0.0.0-20190909230951-414d861bb4ac/go.mod"
	"golang.org/x/lint v0.0.0-20190930215403-16217165b5de/go.mod"
	"golang.org/x/lint v0.0.0-20200302205851-738671d3881b/go.mod"
	"golang.org/x/mobile v0.0.0-20190312151609-d3739f865fa6/go.mod"
	"golang.org/x/mobile v0.0.0-20190719004257-d2bd2a29d028/go.mod"
	"golang.org/x/mod v0.0.0-20190513183733-4bf6d317e70e/go.mod"
	"golang.org/x/mod v0.1.0/go.mod"
	"golang.org/x/mod v0.1.1-0.20191105210325-c90efee705ee/go.mod"
	"golang.org/x/mod v0.2.0/go.mod"
	"golang.org/x/mod v0.3.0/go.mod"
	"golang.org/x/mod v0.4.0/go.mod"
	"golang.org/x/mod v0.4.2"
	"golang.org/x/mod v0.4.2/go.mod"
	"golang.org/x/net v0.0.0-20180218175443-cbe0f9307d01/go.mod"
	"golang.org/x/net v0.0.0-20180724234803-3673e40ba225/go.mod"
	"golang.org/x/net v0.0.0-20180826012351-8a410e7b638d/go.mod"
	"golang.org/x/net v0.0.0-20180906233101-161cd47e91fd/go.mod"
	"golang.org/x/net v0.0.0-20181023162649-9b4f9f5ad519/go.mod"
	"golang.org/x/net v0.0.0-20181029044818-c44066c5c816/go.mod"
	"golang.org/x/net v0.0.0-20181106065722-10aee1819953/go.mod"
	"golang.org/x/net v0.0.0-20181114220301-adae6a3d119a/go.mod"
	"golang.org/x/net v0.0.0-20181201002055-351d144fa1fc/go.mod"
	"golang.org/x/net v0.0.0-20181220203305-927f97764cc3/go.mod"
	"golang.org/x/net v0.0.0-20190108225652-1e06a53dbb7e/go.mod"
	"golang.org/x/net v0.0.0-20190213061140-3a22650c66bd/go.mod"
	"golang.org/x/net v0.0.0-20190311183353-d8887717615a/go.mod"
	"golang.org/x/net v0.0.0-20190313220215-9f648a60d977/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190419010253-1f3472d942ba/go.mod"
	"golang.org/x/net v0.0.0-20190501004415-9ce7a6920f09/go.mod"
	"golang.org/x/net v0.0.0-20190503192946-f4e77d36d62c/go.mod"
	"golang.org/x/net v0.0.0-20190603091049-60506f45cf65/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20190827160401-ba9fcec4b297/go.mod"
	"golang.org/x/net v0.0.0-20191007182048-72f939374954/go.mod"
	"golang.org/x/net v0.0.0-20200202094626-16171245cfb2/go.mod"
	"golang.org/x/net v0.0.0-20200226121028-0de0cce0169b/go.mod"
	"golang.org/x/net v0.0.0-20200324143707-d3edc9973b7e/go.mod"
	"golang.org/x/net v0.0.0-20200520004742-59133d7f0dd7/go.mod"
	"golang.org/x/net v0.0.0-20200625001655-4c5254603344/go.mod"
	"golang.org/x/net v0.0.0-20200707034311-ab3426394381/go.mod"
	"golang.org/x/net v0.0.0-20200822124328-c89045814202/go.mod"
	"golang.org/x/net v0.0.0-20201010224723-4f7140c49acb/go.mod"
	"golang.org/x/net v0.0.0-20201021035429-f5854403a974/go.mod"
	"golang.org/x/net v0.0.0-20201110031124-69a78807bb2b/go.mod"
	"golang.org/x/net v0.0.0-20201202161906-c7110b5ffcbb/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20210405180319-a5a99cb37ef4/go.mod"
	"golang.org/x/net v0.0.0-20210428140749-89ef3d95e781/go.mod"
	"golang.org/x/net v0.0.0-20210813160813-60bc85c4be6d"
	"golang.org/x/net v0.0.0-20210813160813-60bc85c4be6d/go.mod"
	"golang.org/x/oauth2 v0.0.0-20180821212333-d2e6202438be/go.mod"
	"golang.org/x/oauth2 v0.0.0-20181017192945-9dcd33a902f4/go.mod"
	"golang.org/x/oauth2 v0.0.0-20181203162652-d668ce993890/go.mod"
	"golang.org/x/oauth2 v0.0.0-20190226205417-e64efc72b421/go.mod"
	"golang.org/x/oauth2 v0.0.0-20190604053449-0f29369cfe45/go.mod"
	"golang.org/x/oauth2 v0.0.0-20200107190931-bf48bf16ab8d/go.mod"
	"golang.org/x/perf v0.0.0-20180704124530-6e6d33e29852/go.mod"
	"golang.org/x/sync v0.0.0-20180314180146-1d60e4601c6f/go.mod"
	"golang.org/x/sync v0.0.0-20181108010431-42b317875d0f/go.mod"
	"golang.org/x/sync v0.0.0-20181221193216-37e7f081c4d4/go.mod"
	"golang.org/x/sync v0.0.0-20190227155943-e225da77a7e6/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20190911185100-cd5d95a43a6e/go.mod"
	"golang.org/x/sync v0.0.0-20200625203802-6e8e738ad208/go.mod"
	"golang.org/x/sync v0.0.0-20201020160332-67f06af15bc9/go.mod"
	"golang.org/x/sync v0.0.0-20210220032951-036812b2e83c"
	"golang.org/x/sync v0.0.0-20210220032951-036812b2e83c/go.mod"
	"golang.org/x/sys v0.0.0-20180823144017-11551d06cbcc/go.mod"
	"golang.org/x/sys v0.0.0-20180830151530-49385e6e1522/go.mod"
	"golang.org/x/sys v0.0.0-20180905080454-ebe1bf3edb33/go.mod"
	"golang.org/x/sys v0.0.0-20180909124046-d0be0721c37e/go.mod"
	"golang.org/x/sys v0.0.0-20181026203630-95b1ffbd15a5/go.mod"
	"golang.org/x/sys v0.0.0-20181029174526-d69651ed3497/go.mod"
	"golang.org/x/sys v0.0.0-20181107165924-66b7b1311ac8/go.mod"
	"golang.org/x/sys v0.0.0-20181116152217-5ac8a444bdc5/go.mod"
	"golang.org/x/sys v0.0.0-20190116161447-11f53e031339/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190312061237-fead79001313/go.mod"
	"golang.org/x/sys v0.0.0-20190316082340-a2f829d7f35f/go.mod"
	"golang.org/x/sys v0.0.0-20190411185658-b44545bcd369/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20190418153312-f0ce4c0180be/go.mod"
	"golang.org/x/sys v0.0.0-20190502145724-3ef323f4f1fd/go.mod"
	"golang.org/x/sys v0.0.0-20190507160741-ecd444e8653b/go.mod"
	"golang.org/x/sys v0.0.0-20190606122018-79a91cf218c4/go.mod"
	"golang.org/x/sys v0.0.0-20190606165138-5da285871e9c/go.mod"
	"golang.org/x/sys v0.0.0-20190624142023-c5567b49c5d0/go.mod"
	"golang.org/x/sys v0.0.0-20190813064441-fde4db37ae7a/go.mod"
	"golang.org/x/sys v0.0.0-20190826190057-c7b8b68b1456/go.mod"
	"golang.org/x/sys v0.0.0-20190902133755-9109b7679e13/go.mod"
	"golang.org/x/sys v0.0.0-20190904154756-749cb33beabd/go.mod"
	"golang.org/x/sys v0.0.0-20190916202348-b4ddaad3f8a3/go.mod"
	"golang.org/x/sys v0.0.0-20191005200804-aed5e4c7ecf9/go.mod"
	"golang.org/x/sys v0.0.0-20191008105621-543471e840be/go.mod"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
	"golang.org/x/sys v0.0.0-20191120155948-bd437916bb0e/go.mod"
	"golang.org/x/sys v0.0.0-20191224085550-c709ea063b76/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20200202164722-d101bd2416d5/go.mod"
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae/go.mod"
	"golang.org/x/sys v0.0.0-20200323222414-85ca7c5b95cd/go.mod"
	"golang.org/x/sys v0.0.0-20200413165638-669c56c373c4/go.mod"
	"golang.org/x/sys v0.0.0-20200519105757-fe76b779f299/go.mod"
	"golang.org/x/sys v0.0.0-20200808120158-1030fc2bf1d9/go.mod"
	"golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f/go.mod"
	"golang.org/x/sys v0.0.0-20201009025420-dfb3f7c4e634/go.mod"
	"golang.org/x/sys v0.0.0-20201101102859-da207088b7d1/go.mod"
	"golang.org/x/sys v0.0.0-20201112073958-5cba982894dd/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20201202213521-69691e467435/go.mod"
	"golang.org/x/sys v0.0.0-20210112080510-489259a85091/go.mod"
	"golang.org/x/sys v0.0.0-20210119212857-b64e53b001e4/go.mod"
	"golang.org/x/sys v0.0.0-20210303074136-134d130e1a04/go.mod"
	"golang.org/x/sys v0.0.0-20210330210617-4fbd30eecc44/go.mod"
	"golang.org/x/sys v0.0.0-20210403161142-5e06dd20ab57/go.mod"
	"golang.org/x/sys v0.0.0-20210423082822-04245dca01da/go.mod"
	"golang.org/x/sys v0.0.0-20210510120138-977fb7262007/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20210820121016-41cdb8703e55"
	"golang.org/x/sys v0.0.0-20210820121016-41cdb8703e55/go.mod"
	"golang.org/x/term v0.0.0-20201117132131-f5c789dd3221/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.1-0.20180807135948-17ff2d5776d2/go.mod"
	"golang.org/x/text v0.3.2/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.6"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/time v0.0.0-20180412165947-fbb02b2291d2/go.mod"
	"golang.org/x/time v0.0.0-20181108054448-85acf8d2951c/go.mod"
	"golang.org/x/time v0.0.0-20190308202827-9d24e82272b4/go.mod"
	"golang.org/x/tools v0.0.0-20180221164845-07fd8470d635/go.mod"
	"golang.org/x/tools v0.0.0-20180828015842-6cd1fcedba52/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20181030000716-a0a13e073c7b/go.mod"
	"golang.org/x/tools v0.0.0-20190114222345-bf090417da8b/go.mod"
	"golang.org/x/tools v0.0.0-20190226205152-f727befe758c/go.mod"
	"golang.org/x/tools v0.0.0-20190311212946-11955173bddd/go.mod"
	"golang.org/x/tools v0.0.0-20190312151545-0bb0c0a6e846/go.mod"
	"golang.org/x/tools v0.0.0-20190312170243-e65039ee4138/go.mod"
	"golang.org/x/tools v0.0.0-20190328211700-ab21143f2384/go.mod"
	"golang.org/x/tools v0.0.0-20190425150028-36563e24a262/go.mod"
	"golang.org/x/tools v0.0.0-20190506145303-2d16b83fe98c/go.mod"
	"golang.org/x/tools v0.0.0-20190524140312-2c0ae7006135/go.mod"
	"golang.org/x/tools v0.0.0-20190606124116-d0a3d012864b/go.mod"
	"golang.org/x/tools v0.0.0-20190621195816-6e04913cbbac/go.mod"
	"golang.org/x/tools v0.0.0-20190628153133-6cdbf07be9d0/go.mod"
	"golang.org/x/tools v0.0.0-20190816200558-6889da9d5479/go.mod"
	"golang.org/x/tools v0.0.0-20190911174233-4f2ddba30aff/go.mod"
	"golang.org/x/tools v0.0.0-20191012152004-8de300cfc20a/go.mod"
	"golang.org/x/tools v0.0.0-20191112195655-aa38f8e97acc/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.0.0-20191130070609-6e064ea0cf2d/go.mod"
	"golang.org/x/tools v0.0.0-20200130002326-2f3ba24bd6e7/go.mod"
	"golang.org/x/tools v0.0.0-20200425043458-8463f397d07c/go.mod"
	"golang.org/x/tools v0.0.0-20200522201501-cb1345f3a375/go.mod"
	"golang.org/x/tools v0.0.0-20200717024301-6ddee64345a6/go.mod"
	"golang.org/x/tools v0.0.0-20200808161706-5bf02b21f123/go.mod"
	"golang.org/x/tools v0.0.0-20201105001634-bc3cf281b174/go.mod"
	"golang.org/x/tools v0.0.0-20201204062850-545788942d5f/go.mod"
	"golang.org/x/tools v0.0.0-20201224043029-2b0845dc783e/go.mod"
	"golang.org/x/tools v0.1.0/go.mod"
	"golang.org/x/tools v0.1.1"
	"golang.org/x/tools v0.1.1/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1"
	"golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1/go.mod"
	"google.golang.org/api v0.0.0-20180910000450-7ca32eb868bf/go.mod"
	"google.golang.org/api v0.0.0-20181030000543-1d582fd0359e/go.mod"
	"google.golang.org/api v0.1.0/go.mod"
	"google.golang.org/api v0.4.0/go.mod"
	"google.golang.org/api v0.7.0/go.mod"
	"google.golang.org/api v0.8.0/go.mod"
	"google.golang.org/api v0.9.0/go.mod"
	"google.golang.org/api v0.13.0/go.mod"
	"google.golang.org/appengine v1.1.0/go.mod"
	"google.golang.org/appengine v1.2.0/go.mod"
	"google.golang.org/appengine v1.3.0/go.mod"
	"google.golang.org/appengine v1.4.0/go.mod"
	"google.golang.org/appengine v1.5.0/go.mod"
	"google.golang.org/appengine v1.6.1/go.mod"
	"google.golang.org/genproto v0.0.0-20180817151627-c66870c02cf8/go.mod"
	"google.golang.org/genproto v0.0.0-20180831171423-11092d34479b/go.mod"
	"google.golang.org/genproto v0.0.0-20181029155118-b69ba1387ce2/go.mod"
	"google.golang.org/genproto v0.0.0-20181202183823-bd91e49a0898/go.mod"
	"google.golang.org/genproto v0.0.0-20190306203927-b5d61aea6440/go.mod"
	"google.golang.org/genproto v0.0.0-20190307195333-5fe7a883aa19/go.mod"
	"google.golang.org/genproto v0.0.0-20190418145605-e7d98fc518a7/go.mod"
	"google.golang.org/genproto v0.0.0-20190425155659-357c62f0e4bb/go.mod"
	"google.golang.org/genproto v0.0.0-20190502173448-54afdca5d873/go.mod"
	"google.golang.org/genproto v0.0.0-20190801165951-fa694d86fc64/go.mod"
	"google.golang.org/genproto v0.0.0-20190819201941-24fa4b261c55/go.mod"
	"google.golang.org/genproto v0.0.0-20190911173649-1774047e7e51/go.mod"
	"google.golang.org/genproto v0.0.0-20191108220845-16a3f7862a1a/go.mod"
	"google.golang.org/genproto v0.0.0-20200513103714-09dca8ec2884/go.mod"
	"google.golang.org/genproto v0.0.0-20200526211855-cb27e3aa2013"
	"google.golang.org/genproto v0.0.0-20200526211855-cb27e3aa2013/go.mod"
	"google.golang.org/grpc v1.14.0/go.mod"
	"google.golang.org/grpc v1.16.0/go.mod"
	"google.golang.org/grpc v1.17.0/go.mod"
	"google.golang.org/grpc v1.19.0/go.mod"
	"google.golang.org/grpc v1.20.1/go.mod"
	"google.golang.org/grpc v1.21.1/go.mod"
	"google.golang.org/grpc v1.23.0/go.mod"
	"google.golang.org/grpc v1.25.1/go.mod"
	"google.golang.org/grpc v1.27.0/go.mod"
	"google.golang.org/grpc v1.33.1/go.mod"
	"google.golang.org/grpc v1.36.0/go.mod"
	"google.golang.org/grpc v1.40.0"
	"google.golang.org/grpc v1.40.0/go.mod"
	"google.golang.org/protobuf v0.0.0-20200109180630-ec00e32a8dfd/go.mod"
	"google.golang.org/protobuf v0.0.0-20200221191635-4d8936d0db64/go.mod"
	"google.golang.org/protobuf v0.0.0-20200228230310-ab0ca4ff8a60/go.mod"
	"google.golang.org/protobuf v1.20.1-0.20200309200217-e05f789c0967/go.mod"
	"google.golang.org/protobuf v1.21.0/go.mod"
	"google.golang.org/protobuf v1.22.0/go.mod"
	"google.golang.org/protobuf v1.23.0/go.mod"
	"google.golang.org/protobuf v1.23.1-0.20200526195155-81db48ad09cc/go.mod"
	"google.golang.org/protobuf v1.25.0/go.mod"
	"google.golang.org/protobuf v1.25.1-0.20200805231151-a709e31e5d12/go.mod"
	"google.golang.org/protobuf v1.26.0-rc.1/go.mod"
	"google.golang.org/protobuf v1.26.0/go.mod"
	"google.golang.org/protobuf v1.27.1"
	"google.golang.org/protobuf v1.27.1/go.mod"
	"gopkg.in/alecthomas/kingpin.v2 v2.2.6/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f/go.mod"
	"gopkg.in/check.v1 v1.0.0-20200902074654-038fdea0a05b/go.mod"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c/go.mod"
	"gopkg.in/errgo.v2 v2.1.0/go.mod"
	"gopkg.in/fsnotify.v1 v1.4.7/go.mod"
	"gopkg.in/go-playground/assert.v1 v1.2.1/go.mod"
	"gopkg.in/go-playground/validator.v9 v9.29.1/go.mod"
	"gopkg.in/inf.v0 v0.9.1/go.mod"
	"gopkg.in/ini.v1 v1.51.0/go.mod"
	"gopkg.in/resty.v1 v1.12.0/go.mod"
	"gopkg.in/tomb.v1 v1.0.0-20141024135613-dd632973f1e7"
	"gopkg.in/tomb.v1 v1.0.0-20141024135613-dd632973f1e7/go.mod"
	"gopkg.in/yaml.v2 v2.0.0-20170812160011-eb3733d160e7/go.mod"
	"gopkg.in/yaml.v2 v2.2.1/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.2.3/go.mod"
	"gopkg.in/yaml.v2 v2.2.4/go.mod"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
	"gopkg.in/yaml.v2 v2.3.0/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200605160147-a5ece683394c/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b"
	"gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b/go.mod"
	"grpc.go4.org v0.0.0-20170609214715-11d0a25b4919/go.mod"
	"h12.io/socks v1.0.3/go.mod"
	"honnef.co/go/tools v0.0.0-20180728063816-88497007e858/go.mod"
	"honnef.co/go/tools v0.0.0-20190102054323-c2f93a96b099/go.mod"
	"honnef.co/go/tools v0.0.0-20190106161140-3f1c8253044a/go.mod"
	"honnef.co/go/tools v0.0.0-20190418001031-e561f6794a2a/go.mod"
	"honnef.co/go/tools v0.0.0-20190523083050-ea95bdfd59fc/go.mod"
	"honnef.co/go/tools v0.0.1-2019.2.3/go.mod"
	"honnef.co/go/tools v0.0.1-2020.1.4/go.mod"
	"rsc.io/binaryregexp v0.2.0/go.mod"
	"rsc.io/pdf v0.1.1/go.mod"
	"sourcegraph.com/sourcegraph/go-diff v0.5.0/go.mod"
	"sourcegraph.com/sqs/pbtypes v0.0.0-20180604144634-d3ebe8f20ae4/go.mod"
)

go-module_set_globals

# sed -r -n -e 's/^[ ]*resolved \"(.*)\#.*\"$/\1/g; s/^https:\/\/registry.yarnpkg.com\/(@([^@/]+))?\/?([^@/]+)\/\-\/([^/]+).tgz$/\0 -> yarn-pkg-\1-\4.tgz/p' yarn.lock | sort | uniq
SRC_URI="
	https://registry.nlark.com/css-loader/download/css-loader-5.2.7.tgz -> yarn-pkg--css-loader-5.2.7.tgz
	https://registry.nlark.com/dayjs/download/dayjs-1.10.6.tgz -> yarn-pkg--dayjs-1.10.6.tgz
	https://registry.nlark.com/nanoid/download/nanoid-3.1.23.tgz -> yarn-pkg--nanoid-3.1.23.tgz
	https://registry.nlark.com/postcss/download/postcss-8.3.6.tgz -> yarn-pkg--postcss-8.3.6.tgz
	https://registry.nlark.com/postcss-selector-parser/download/postcss-selector-parser-6.0.6.tgz -> yarn-pkg--postcss-selector-parser-6.0.6.tgz
	https://registry.nlark.com/schema-utils/download/schema-utils-3.1.1.tgz -> yarn-pkg--schema-utils-3.1.1.tgz
	https://registry.nlark.com/@types/json-schema/download/@types/json-schema-7.0.9.tgz -> yarn-pkg--json-schema-7.0.9.tgz
	https://registry.npm.taobao.org/icss-utils/download/icss-utils-5.1.0.tgz -> yarn-pkg--icss-utils-5.1.0.tgz
	https://registry.npm.taobao.org/lru-cache/download/lru-cache-6.0.0.tgz -> yarn-pkg--lru-cache-6.0.0.tgz
	https://registry.npm.taobao.org/postcss-modules-extract-imports/download/postcss-modules-extract-imports-3.0.0.tgz -> yarn-pkg--postcss-modules-extract-imports-3.0.0.tgz
	https://registry.npm.taobao.org/postcss-modules-local-by-default/download/postcss-modules-local-by-default-4.0.0.tgz -> yarn-pkg--postcss-modules-local-by-default-4.0.0.tgz
	https://registry.npm.taobao.org/postcss-modules-scope/download/postcss-modules-scope-3.0.0.tgz -> yarn-pkg--postcss-modules-scope-3.0.0.tgz
	https://registry.npm.taobao.org/postcss-modules-values/download/postcss-modules-values-4.0.0.tgz -> yarn-pkg--postcss-modules-values-4.0.0.tgz
	https://registry.npm.taobao.org/semver/download/semver-7.3.5.tgz -> yarn-pkg--semver-7.3.5.tgz
	https://registry.npm.taobao.org/source-map-js/download/source-map-js-0.6.2.tgz -> yarn-pkg--source-map-js-0.6.2.tgz
	https://registry.yarnpkg.com/accepts/-/accepts-1.3.7.tgz -> yarn-pkg--accepts-1.3.7.tgz
	https://registry.yarnpkg.com/acorn/-/acorn-6.4.2.tgz -> yarn-pkg--acorn-6.4.2.tgz
	https://registry.yarnpkg.com/acorn/-/acorn-7.4.1.tgz -> yarn-pkg--acorn-7.4.1.tgz
	https://registry.yarnpkg.com/acorn-jsx/-/acorn-jsx-5.3.1.tgz -> yarn-pkg--acorn-jsx-5.3.1.tgz
	https://registry.yarnpkg.com/acorn-walk/-/acorn-walk-7.2.0.tgz -> yarn-pkg--acorn-walk-7.2.0.tgz
	https://registry.yarnpkg.com/address/-/address-1.1.2.tgz -> yarn-pkg--address-1.1.2.tgz
	https://registry.yarnpkg.com/aggregate-error/-/aggregate-error-3.1.0.tgz -> yarn-pkg--aggregate-error-3.1.0.tgz
	https://registry.yarnpkg.com/ajv/-/ajv-6.12.6.tgz -> yarn-pkg--ajv-6.12.6.tgz
	https://registry.yarnpkg.com/ajv-errors/-/ajv-errors-1.0.1.tgz -> yarn-pkg--ajv-errors-1.0.1.tgz
	https://registry.yarnpkg.com/ajv-keywords/-/ajv-keywords-3.5.2.tgz -> yarn-pkg--ajv-keywords-3.5.2.tgz
	https://registry.yarnpkg.com/alphanum-sort/-/alphanum-sort-1.0.2.tgz -> yarn-pkg--alphanum-sort-1.0.2.tgz
	https://registry.yarnpkg.com/ansi-colors/-/ansi-colors-3.2.4.tgz -> yarn-pkg--ansi-colors-3.2.4.tgz
	https://registry.yarnpkg.com/ansi-escapes/-/ansi-escapes-3.2.0.tgz -> yarn-pkg--ansi-escapes-3.2.0.tgz
	https://registry.yarnpkg.com/ansi-escapes/-/ansi-escapes-4.3.1.tgz -> yarn-pkg--ansi-escapes-4.3.1.tgz
	https://registry.yarnpkg.com/ansi-html/-/ansi-html-0.0.7.tgz -> yarn-pkg--ansi-html-0.0.7.tgz
	https://registry.yarnpkg.com/ansi-regex/-/ansi-regex-2.1.1.tgz -> yarn-pkg--ansi-regex-2.1.1.tgz
	https://registry.yarnpkg.com/ansi-regex/-/ansi-regex-3.0.0.tgz -> yarn-pkg--ansi-regex-3.0.0.tgz
	https://registry.yarnpkg.com/ansi-regex/-/ansi-regex-4.1.0.tgz -> yarn-pkg--ansi-regex-4.1.0.tgz
	https://registry.yarnpkg.com/ansi-regex/-/ansi-regex-5.0.0.tgz -> yarn-pkg--ansi-regex-5.0.0.tgz
	https://registry.yarnpkg.com/ansi-styles/-/ansi-styles-3.2.1.tgz -> yarn-pkg--ansi-styles-3.2.1.tgz
	https://registry.yarnpkg.com/ansi-styles/-/ansi-styles-4.3.0.tgz -> yarn-pkg--ansi-styles-4.3.0.tgz
	https://registry.yarnpkg.com/anymatch/-/anymatch-2.0.0.tgz -> yarn-pkg--anymatch-2.0.0.tgz
	https://registry.yarnpkg.com/anymatch/-/anymatch-3.1.1.tgz -> yarn-pkg--anymatch-3.1.1.tgz
	https://registry.yarnpkg.com/any-promise/-/any-promise-1.3.0.tgz -> yarn-pkg--any-promise-1.3.0.tgz
	https://registry.yarnpkg.com/aproba/-/aproba-1.2.0.tgz -> yarn-pkg--aproba-1.2.0.tgz
	https://registry.yarnpkg.com/arch/-/arch-2.2.0.tgz -> yarn-pkg--arch-2.2.0.tgz
	https://registry.yarnpkg.com/argparse/-/argparse-1.0.10.tgz -> yarn-pkg--argparse-1.0.10.tgz
	https://registry.yarnpkg.com/array-flatten/-/array-flatten-1.1.1.tgz -> yarn-pkg--array-flatten-1.1.1.tgz
	https://registry.yarnpkg.com/array-flatten/-/array-flatten-2.1.2.tgz -> yarn-pkg--array-flatten-2.1.2.tgz
	https://registry.yarnpkg.com/array-union/-/array-union-1.0.2.tgz -> yarn-pkg--array-union-1.0.2.tgz
	https://registry.yarnpkg.com/array-uniq/-/array-uniq-1.0.3.tgz -> yarn-pkg--array-uniq-1.0.3.tgz
	https://registry.yarnpkg.com/array-unique/-/array-unique-0.3.2.tgz -> yarn-pkg--array-unique-0.3.2.tgz
	https://registry.yarnpkg.com/arr-diff/-/arr-diff-4.0.0.tgz -> yarn-pkg--arr-diff-4.0.0.tgz
	https://registry.yarnpkg.com/arr-flatten/-/arr-flatten-1.1.0.tgz -> yarn-pkg--arr-flatten-1.1.0.tgz
	https://registry.yarnpkg.com/arrify/-/arrify-1.0.1.tgz -> yarn-pkg--arrify-1.0.1.tgz
	https://registry.yarnpkg.com/arr-union/-/arr-union-3.1.0.tgz -> yarn-pkg--arr-union-3.1.0.tgz
	https://registry.yarnpkg.com/asap/-/asap-2.0.6.tgz -> yarn-pkg--asap-2.0.6.tgz
	https://registry.yarnpkg.com/asn1/-/asn1-0.2.4.tgz -> yarn-pkg--asn1-0.2.4.tgz
	https://registry.yarnpkg.com/asn1.js/-/asn1.js-5.4.1.tgz -> yarn-pkg--asn1.js-5.4.1.tgz
	https://registry.yarnpkg.com/assert/-/assert-1.5.0.tgz -> yarn-pkg--assert-1.5.0.tgz
	https://registry.yarnpkg.com/assert-plus/-/assert-plus-1.0.0.tgz -> yarn-pkg--assert-plus-1.0.0.tgz
	https://registry.yarnpkg.com/assign-symbols/-/assign-symbols-1.0.0.tgz -> yarn-pkg--assign-symbols-1.0.0.tgz
	https://registry.yarnpkg.com/astral-regex/-/astral-regex-1.0.0.tgz -> yarn-pkg--astral-regex-1.0.0.tgz
	https://registry.yarnpkg.com/async/-/async-2.6.3.tgz -> yarn-pkg--async-2.6.3.tgz
	https://registry.yarnpkg.com/async-each/-/async-each-1.0.3.tgz -> yarn-pkg--async-each-1.0.3.tgz
	https://registry.yarnpkg.com/asynckit/-/asynckit-0.4.0.tgz -> yarn-pkg--asynckit-0.4.0.tgz
	https://registry.yarnpkg.com/async-limiter/-/async-limiter-1.0.1.tgz -> yarn-pkg--async-limiter-1.0.1.tgz
	https://registry.yarnpkg.com/async-throttle/-/async-throttle-1.1.0.tgz -> yarn-pkg--async-throttle-1.1.0.tgz
	https://registry.yarnpkg.com/a-sync-waterfall/-/a-sync-waterfall-1.0.1.tgz -> yarn-pkg--a-sync-waterfall-1.0.1.tgz
	https://registry.yarnpkg.com/atob/-/atob-2.1.2.tgz -> yarn-pkg--atob-2.1.2.tgz
	https://registry.yarnpkg.com/autoprefixer/-/autoprefixer-9.8.6.tgz -> yarn-pkg--autoprefixer-9.8.6.tgz
	https://registry.yarnpkg.com/aws4/-/aws4-1.11.0.tgz -> yarn-pkg--aws4-1.11.0.tgz
	https://registry.yarnpkg.com/aws-sign2/-/aws-sign2-0.7.0.tgz -> yarn-pkg--aws-sign2-0.7.0.tgz
	https://registry.yarnpkg.com/axios/-/axios-0.21.1.tgz -> yarn-pkg--axios-0.21.1.tgz
	https://registry.yarnpkg.com/@babel/code-frame/-/code-frame-7.12.11.tgz -> yarn-pkg-@babel-code-frame-7.12.11.tgz
	https://registry.yarnpkg.com/@babel/compat-data/-/compat-data-7.12.7.tgz -> yarn-pkg-@babel-compat-data-7.12.7.tgz
	https://registry.yarnpkg.com/@babel/core/-/core-7.12.10.tgz -> yarn-pkg-@babel-core-7.12.10.tgz
	https://registry.yarnpkg.com/babel-eslint/-/babel-eslint-10.1.0.tgz -> yarn-pkg--babel-eslint-10.1.0.tgz
	https://registry.yarnpkg.com/@babel/generator/-/generator-7.12.11.tgz -> yarn-pkg-@babel-generator-7.12.11.tgz
	https://registry.yarnpkg.com/@babel/helper-annotate-as-pure/-/helper-annotate-as-pure-7.12.10.tgz -> yarn-pkg-@babel-helper-annotate-as-pure-7.12.10.tgz
	https://registry.yarnpkg.com/@babel/helper-builder-binary-assignment-operator-visitor/-/helper-builder-binary-assignment-operator-visitor-7.10.4.tgz -> yarn-pkg-@babel-helper-builder-binary-assignment-operator-visitor-7.10.4.tgz
	https://registry.yarnpkg.com/@babel/helper-compilation-targets/-/helper-compilation-targets-7.12.5.tgz -> yarn-pkg-@babel-helper-compilation-targets-7.12.5.tgz
	https://registry.yarnpkg.com/@babel/helper-create-class-features-plugin/-/helper-create-class-features-plugin-7.12.1.tgz -> yarn-pkg-@babel-helper-create-class-features-plugin-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/helper-create-regexp-features-plugin/-/helper-create-regexp-features-plugin-7.12.7.tgz -> yarn-pkg-@babel-helper-create-regexp-features-plugin-7.12.7.tgz
	https://registry.yarnpkg.com/@babel/helper-define-map/-/helper-define-map-7.10.5.tgz -> yarn-pkg-@babel-helper-define-map-7.10.5.tgz
	https://registry.yarnpkg.com/@babel/helper-explode-assignable-expression/-/helper-explode-assignable-expression-7.12.1.tgz -> yarn-pkg-@babel-helper-explode-assignable-expression-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/helper-function-name/-/helper-function-name-7.12.11.tgz -> yarn-pkg-@babel-helper-function-name-7.12.11.tgz
	https://registry.yarnpkg.com/@babel/helper-get-function-arity/-/helper-get-function-arity-7.12.10.tgz -> yarn-pkg-@babel-helper-get-function-arity-7.12.10.tgz
	https://registry.yarnpkg.com/@babel/helper-hoist-variables/-/helper-hoist-variables-7.10.4.tgz -> yarn-pkg-@babel-helper-hoist-variables-7.10.4.tgz
	https://registry.yarnpkg.com/@babel/helper-member-expression-to-functions/-/helper-member-expression-to-functions-7.12.7.tgz -> yarn-pkg-@babel-helper-member-expression-to-functions-7.12.7.tgz
	https://registry.yarnpkg.com/@babel/helper-module-imports/-/helper-module-imports-7.12.5.tgz -> yarn-pkg-@babel-helper-module-imports-7.12.5.tgz
	https://registry.yarnpkg.com/@babel/helper-module-transforms/-/helper-module-transforms-7.12.1.tgz -> yarn-pkg-@babel-helper-module-transforms-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/helper-optimise-call-expression/-/helper-optimise-call-expression-7.12.10.tgz -> yarn-pkg-@babel-helper-optimise-call-expression-7.12.10.tgz
	https://registry.yarnpkg.com/@babel/helper-plugin-utils/-/helper-plugin-utils-7.10.4.tgz -> yarn-pkg-@babel-helper-plugin-utils-7.10.4.tgz
	https://registry.yarnpkg.com/@babel/helper-remap-async-to-generator/-/helper-remap-async-to-generator-7.12.1.tgz -> yarn-pkg-@babel-helper-remap-async-to-generator-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/helper-replace-supers/-/helper-replace-supers-7.12.11.tgz -> yarn-pkg-@babel-helper-replace-supers-7.12.11.tgz
	https://registry.yarnpkg.com/@babel/helpers/-/helpers-7.12.5.tgz -> yarn-pkg-@babel-helpers-7.12.5.tgz
	https://registry.yarnpkg.com/@babel/helper-simple-access/-/helper-simple-access-7.12.1.tgz -> yarn-pkg-@babel-helper-simple-access-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/helper-skip-transparent-expression-wrappers/-/helper-skip-transparent-expression-wrappers-7.12.1.tgz -> yarn-pkg-@babel-helper-skip-transparent-expression-wrappers-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/helper-split-export-declaration/-/helper-split-export-declaration-7.12.11.tgz -> yarn-pkg-@babel-helper-split-export-declaration-7.12.11.tgz
	https://registry.yarnpkg.com/@babel/helper-validator-identifier/-/helper-validator-identifier-7.12.11.tgz -> yarn-pkg-@babel-helper-validator-identifier-7.12.11.tgz
	https://registry.yarnpkg.com/@babel/helper-validator-option/-/helper-validator-option-7.12.11.tgz -> yarn-pkg-@babel-helper-validator-option-7.12.11.tgz
	https://registry.yarnpkg.com/@babel/helper-wrap-function/-/helper-wrap-function-7.12.3.tgz -> yarn-pkg-@babel-helper-wrap-function-7.12.3.tgz
	https://registry.yarnpkg.com/@babel/highlight/-/highlight-7.10.4.tgz -> yarn-pkg-@babel-highlight-7.10.4.tgz
	https://registry.yarnpkg.com/babel-loader/-/babel-loader-8.2.2.tgz -> yarn-pkg--babel-loader-8.2.2.tgz
	https://registry.yarnpkg.com/@babel/parser/-/parser-7.12.11.tgz -> yarn-pkg-@babel-parser-7.12.11.tgz
	https://registry.yarnpkg.com/babel-plugin-dynamic-import-node/-/babel-plugin-dynamic-import-node-2.3.3.tgz -> yarn-pkg--babel-plugin-dynamic-import-node-2.3.3.tgz
	https://registry.yarnpkg.com/@babel/plugin-proposal-async-generator-functions/-/plugin-proposal-async-generator-functions-7.12.12.tgz -> yarn-pkg-@babel-plugin-proposal-async-generator-functions-7.12.12.tgz
	https://registry.yarnpkg.com/@babel/plugin-proposal-class-properties/-/plugin-proposal-class-properties-7.12.1.tgz -> yarn-pkg-@babel-plugin-proposal-class-properties-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-proposal-decorators/-/plugin-proposal-decorators-7.12.12.tgz -> yarn-pkg-@babel-plugin-proposal-decorators-7.12.12.tgz
	https://registry.yarnpkg.com/@babel/plugin-proposal-dynamic-import/-/plugin-proposal-dynamic-import-7.12.1.tgz -> yarn-pkg-@babel-plugin-proposal-dynamic-import-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-proposal-export-namespace-from/-/plugin-proposal-export-namespace-from-7.12.1.tgz -> yarn-pkg-@babel-plugin-proposal-export-namespace-from-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-proposal-json-strings/-/plugin-proposal-json-strings-7.12.1.tgz -> yarn-pkg-@babel-plugin-proposal-json-strings-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-proposal-logical-assignment-operators/-/plugin-proposal-logical-assignment-operators-7.12.1.tgz -> yarn-pkg-@babel-plugin-proposal-logical-assignment-operators-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-proposal-nullish-coalescing-operator/-/plugin-proposal-nullish-coalescing-operator-7.12.1.tgz -> yarn-pkg-@babel-plugin-proposal-nullish-coalescing-operator-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-proposal-numeric-separator/-/plugin-proposal-numeric-separator-7.12.7.tgz -> yarn-pkg-@babel-plugin-proposal-numeric-separator-7.12.7.tgz
	https://registry.yarnpkg.com/@babel/plugin-proposal-object-rest-spread/-/plugin-proposal-object-rest-spread-7.12.1.tgz -> yarn-pkg-@babel-plugin-proposal-object-rest-spread-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-proposal-optional-catch-binding/-/plugin-proposal-optional-catch-binding-7.12.1.tgz -> yarn-pkg-@babel-plugin-proposal-optional-catch-binding-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-proposal-optional-chaining/-/plugin-proposal-optional-chaining-7.12.7.tgz -> yarn-pkg-@babel-plugin-proposal-optional-chaining-7.12.7.tgz
	https://registry.yarnpkg.com/@babel/plugin-proposal-private-methods/-/plugin-proposal-private-methods-7.12.1.tgz -> yarn-pkg-@babel-plugin-proposal-private-methods-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-proposal-unicode-property-regex/-/plugin-proposal-unicode-property-regex-7.12.1.tgz -> yarn-pkg-@babel-plugin-proposal-unicode-property-regex-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-syntax-async-generators/-/plugin-syntax-async-generators-7.8.4.tgz -> yarn-pkg-@babel-plugin-syntax-async-generators-7.8.4.tgz
	https://registry.yarnpkg.com/@babel/plugin-syntax-class-properties/-/plugin-syntax-class-properties-7.12.1.tgz -> yarn-pkg-@babel-plugin-syntax-class-properties-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-syntax-decorators/-/plugin-syntax-decorators-7.12.1.tgz -> yarn-pkg-@babel-plugin-syntax-decorators-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-syntax-dynamic-import/-/plugin-syntax-dynamic-import-7.8.3.tgz -> yarn-pkg-@babel-plugin-syntax-dynamic-import-7.8.3.tgz
	https://registry.yarnpkg.com/@babel/plugin-syntax-export-namespace-from/-/plugin-syntax-export-namespace-from-7.8.3.tgz -> yarn-pkg-@babel-plugin-syntax-export-namespace-from-7.8.3.tgz
	https://registry.yarnpkg.com/@babel/plugin-syntax-json-strings/-/plugin-syntax-json-strings-7.8.3.tgz -> yarn-pkg-@babel-plugin-syntax-json-strings-7.8.3.tgz
	https://registry.yarnpkg.com/@babel/plugin-syntax-jsx/-/plugin-syntax-jsx-7.12.1.tgz -> yarn-pkg-@babel-plugin-syntax-jsx-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-syntax-logical-assignment-operators/-/plugin-syntax-logical-assignment-operators-7.10.4.tgz -> yarn-pkg-@babel-plugin-syntax-logical-assignment-operators-7.10.4.tgz
	https://registry.yarnpkg.com/@babel/plugin-syntax-nullish-coalescing-operator/-/plugin-syntax-nullish-coalescing-operator-7.8.3.tgz -> yarn-pkg-@babel-plugin-syntax-nullish-coalescing-operator-7.8.3.tgz
	https://registry.yarnpkg.com/@babel/plugin-syntax-numeric-separator/-/plugin-syntax-numeric-separator-7.10.4.tgz -> yarn-pkg-@babel-plugin-syntax-numeric-separator-7.10.4.tgz
	https://registry.yarnpkg.com/@babel/plugin-syntax-object-rest-spread/-/plugin-syntax-object-rest-spread-7.8.3.tgz -> yarn-pkg-@babel-plugin-syntax-object-rest-spread-7.8.3.tgz
	https://registry.yarnpkg.com/@babel/plugin-syntax-optional-catch-binding/-/plugin-syntax-optional-catch-binding-7.8.3.tgz -> yarn-pkg-@babel-plugin-syntax-optional-catch-binding-7.8.3.tgz
	https://registry.yarnpkg.com/@babel/plugin-syntax-optional-chaining/-/plugin-syntax-optional-chaining-7.8.3.tgz -> yarn-pkg-@babel-plugin-syntax-optional-chaining-7.8.3.tgz
	https://registry.yarnpkg.com/@babel/plugin-syntax-top-level-await/-/plugin-syntax-top-level-await-7.12.1.tgz -> yarn-pkg-@babel-plugin-syntax-top-level-await-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-arrow-functions/-/plugin-transform-arrow-functions-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-arrow-functions-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-async-to-generator/-/plugin-transform-async-to-generator-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-async-to-generator-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-block-scoped-functions/-/plugin-transform-block-scoped-functions-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-block-scoped-functions-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-block-scoping/-/plugin-transform-block-scoping-7.12.12.tgz -> yarn-pkg-@babel-plugin-transform-block-scoping-7.12.12.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-classes/-/plugin-transform-classes-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-classes-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-computed-properties/-/plugin-transform-computed-properties-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-computed-properties-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-destructuring/-/plugin-transform-destructuring-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-destructuring-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-dotall-regex/-/plugin-transform-dotall-regex-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-dotall-regex-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-duplicate-keys/-/plugin-transform-duplicate-keys-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-duplicate-keys-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-exponentiation-operator/-/plugin-transform-exponentiation-operator-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-exponentiation-operator-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-for-of/-/plugin-transform-for-of-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-for-of-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-function-name/-/plugin-transform-function-name-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-function-name-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-literals/-/plugin-transform-literals-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-literals-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-member-expression-literals/-/plugin-transform-member-expression-literals-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-member-expression-literals-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-modules-amd/-/plugin-transform-modules-amd-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-modules-amd-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-modules-commonjs/-/plugin-transform-modules-commonjs-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-modules-commonjs-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-modules-systemjs/-/plugin-transform-modules-systemjs-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-modules-systemjs-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-modules-umd/-/plugin-transform-modules-umd-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-modules-umd-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-named-capturing-groups-regex/-/plugin-transform-named-capturing-groups-regex-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-named-capturing-groups-regex-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-new-target/-/plugin-transform-new-target-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-new-target-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-object-super/-/plugin-transform-object-super-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-object-super-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-parameters/-/plugin-transform-parameters-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-parameters-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-property-literals/-/plugin-transform-property-literals-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-property-literals-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-regenerator/-/plugin-transform-regenerator-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-regenerator-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-reserved-words/-/plugin-transform-reserved-words-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-reserved-words-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-runtime/-/plugin-transform-runtime-7.12.10.tgz -> yarn-pkg-@babel-plugin-transform-runtime-7.12.10.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-shorthand-properties/-/plugin-transform-shorthand-properties-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-shorthand-properties-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-spread/-/plugin-transform-spread-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-spread-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-sticky-regex/-/plugin-transform-sticky-regex-7.12.7.tgz -> yarn-pkg-@babel-plugin-transform-sticky-regex-7.12.7.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-template-literals/-/plugin-transform-template-literals-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-template-literals-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-typeof-symbol/-/plugin-transform-typeof-symbol-7.12.10.tgz -> yarn-pkg-@babel-plugin-transform-typeof-symbol-7.12.10.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-unicode-escapes/-/plugin-transform-unicode-escapes-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-unicode-escapes-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/plugin-transform-unicode-regex/-/plugin-transform-unicode-regex-7.12.1.tgz -> yarn-pkg-@babel-plugin-transform-unicode-regex-7.12.1.tgz
	https://registry.yarnpkg.com/@babel/preset-env/-/preset-env-7.12.11.tgz -> yarn-pkg-@babel-preset-env-7.12.11.tgz
	https://registry.yarnpkg.com/@babel/preset-modules/-/preset-modules-0.1.4.tgz -> yarn-pkg-@babel-preset-modules-0.1.4.tgz
	https://registry.yarnpkg.com/@babel/runtime/-/runtime-7.12.5.tgz -> yarn-pkg-@babel-runtime-7.12.5.tgz
	https://registry.yarnpkg.com/@babel/template/-/template-7.12.7.tgz -> yarn-pkg-@babel-template-7.12.7.tgz
	https://registry.yarnpkg.com/@babel/traverse/-/traverse-7.12.12.tgz -> yarn-pkg-@babel-traverse-7.12.12.tgz
	https://registry.yarnpkg.com/@babel/types/-/types-7.12.12.tgz -> yarn-pkg-@babel-types-7.12.12.tgz
	https://registry.yarnpkg.com/balanced-match/-/balanced-match-1.0.0.tgz -> yarn-pkg--balanced-match-1.0.0.tgz
	https://registry.yarnpkg.com/base64-js/-/base64-js-1.5.1.tgz -> yarn-pkg--base64-js-1.5.1.tgz
	https://registry.yarnpkg.com/base/-/base-0.11.2.tgz -> yarn-pkg--base-0.11.2.tgz
	https://registry.yarnpkg.com/batch/-/batch-0.6.1.tgz -> yarn-pkg--batch-0.6.1.tgz
	https://registry.yarnpkg.com/bcrypt-pbkdf/-/bcrypt-pbkdf-1.0.2.tgz -> yarn-pkg--bcrypt-pbkdf-1.0.2.tgz
	https://registry.yarnpkg.com/bfj/-/bfj-6.1.2.tgz -> yarn-pkg--bfj-6.1.2.tgz
	https://registry.yarnpkg.com/big.js/-/big.js-3.2.0.tgz -> yarn-pkg--big.js-3.2.0.tgz
	https://registry.yarnpkg.com/big.js/-/big.js-5.2.2.tgz -> yarn-pkg--big.js-5.2.2.tgz
	https://registry.yarnpkg.com/binary-extensions/-/binary-extensions-1.13.1.tgz -> yarn-pkg--binary-extensions-1.13.1.tgz
	https://registry.yarnpkg.com/binary-extensions/-/binary-extensions-2.1.0.tgz -> yarn-pkg--binary-extensions-2.1.0.tgz
	https://registry.yarnpkg.com/bindings/-/bindings-1.5.0.tgz -> yarn-pkg--bindings-1.5.0.tgz
	https://registry.yarnpkg.com/bluebird/-/bluebird-3.7.2.tgz -> yarn-pkg--bluebird-3.7.2.tgz
	https://registry.yarnpkg.com/bn.js/-/bn.js-4.12.0.tgz -> yarn-pkg--bn.js-4.12.0.tgz
	https://registry.yarnpkg.com/bn.js/-/bn.js-5.1.3.tgz -> yarn-pkg--bn.js-5.1.3.tgz
	https://registry.yarnpkg.com/body-parser/-/body-parser-1.19.0.tgz -> yarn-pkg--body-parser-1.19.0.tgz
	https://registry.yarnpkg.com/bonjour/-/bonjour-3.5.0.tgz -> yarn-pkg--bonjour-3.5.0.tgz
	https://registry.yarnpkg.com/boolbase/-/boolbase-1.0.0.tgz -> yarn-pkg--boolbase-1.0.0.tgz
	https://registry.yarnpkg.com/brace-expansion/-/brace-expansion-1.1.11.tgz -> yarn-pkg--brace-expansion-1.1.11.tgz
	https://registry.yarnpkg.com/braces/-/braces-2.3.2.tgz -> yarn-pkg--braces-2.3.2.tgz
	https://registry.yarnpkg.com/braces/-/braces-3.0.2.tgz -> yarn-pkg--braces-3.0.2.tgz
	https://registry.yarnpkg.com/brorand/-/brorand-1.1.0.tgz -> yarn-pkg--brorand-1.1.0.tgz
	https://registry.yarnpkg.com/browserify-aes/-/browserify-aes-1.2.0.tgz -> yarn-pkg--browserify-aes-1.2.0.tgz
	https://registry.yarnpkg.com/browserify-cipher/-/browserify-cipher-1.0.1.tgz -> yarn-pkg--browserify-cipher-1.0.1.tgz
	https://registry.yarnpkg.com/browserify-des/-/browserify-des-1.0.2.tgz -> yarn-pkg--browserify-des-1.0.2.tgz
	https://registry.yarnpkg.com/browserify-rsa/-/browserify-rsa-4.1.0.tgz -> yarn-pkg--browserify-rsa-4.1.0.tgz
	https://registry.yarnpkg.com/browserify-sign/-/browserify-sign-4.2.1.tgz -> yarn-pkg--browserify-sign-4.2.1.tgz
	https://registry.yarnpkg.com/browserify-zlib/-/browserify-zlib-0.2.0.tgz -> yarn-pkg--browserify-zlib-0.2.0.tgz
	https://registry.yarnpkg.com/browserslist/-/browserslist-4.16.6.tgz -> yarn-pkg--browserslist-4.16.6.tgz
	https://registry.yarnpkg.com/buefy/-/buefy-0.9.3.tgz -> yarn-pkg--buefy-0.9.3.tgz
	https://registry.yarnpkg.com/buffer-alloc/-/buffer-alloc-1.2.0.tgz -> yarn-pkg--buffer-alloc-1.2.0.tgz
	https://registry.yarnpkg.com/buffer-alloc-unsafe/-/buffer-alloc-unsafe-1.1.0.tgz -> yarn-pkg--buffer-alloc-unsafe-1.1.0.tgz
	https://registry.yarnpkg.com/buffer/-/buffer-4.9.2.tgz -> yarn-pkg--buffer-4.9.2.tgz
	https://registry.yarnpkg.com/buffer/-/buffer-5.7.1.tgz -> yarn-pkg--buffer-5.7.1.tgz
	https://registry.yarnpkg.com/buffer-fill/-/buffer-fill-1.0.0.tgz -> yarn-pkg--buffer-fill-1.0.0.tgz
	https://registry.yarnpkg.com/buffer-from/-/buffer-from-1.1.1.tgz -> yarn-pkg--buffer-from-1.1.1.tgz
	https://registry.yarnpkg.com/buffer-indexof/-/buffer-indexof-1.1.1.tgz -> yarn-pkg--buffer-indexof-1.1.1.tgz
	https://registry.yarnpkg.com/buffer-json/-/buffer-json-2.0.0.tgz -> yarn-pkg--buffer-json-2.0.0.tgz
	https://registry.yarnpkg.com/bufferstreams/-/bufferstreams-2.0.1.tgz -> yarn-pkg--bufferstreams-2.0.1.tgz
	https://registry.yarnpkg.com/buffer-xor/-/buffer-xor-1.0.3.tgz -> yarn-pkg--buffer-xor-1.0.3.tgz
	https://registry.yarnpkg.com/builtin-status-codes/-/builtin-status-codes-3.0.0.tgz -> yarn-pkg--builtin-status-codes-3.0.0.tgz
	https://registry.yarnpkg.com/bulma/-/bulma-0.9.0.tgz -> yarn-pkg--bulma-0.9.0.tgz
	https://registry.yarnpkg.com/bytes/-/bytes-3.0.0.tgz -> yarn-pkg--bytes-3.0.0.tgz
	https://registry.yarnpkg.com/bytes/-/bytes-3.1.0.tgz -> yarn-pkg--bytes-3.1.0.tgz
	https://registry.yarnpkg.com/cacache/-/cacache-10.0.4.tgz -> yarn-pkg--cacache-10.0.4.tgz
	https://registry.yarnpkg.com/cacache/-/cacache-12.0.4.tgz -> yarn-pkg--cacache-12.0.4.tgz
	https://registry.yarnpkg.com/cacache/-/cacache-13.0.1.tgz -> yarn-pkg--cacache-13.0.1.tgz
	https://registry.yarnpkg.com/cache-base/-/cache-base-1.0.1.tgz -> yarn-pkg--cache-base-1.0.1.tgz
	https://registry.yarnpkg.com/cache-loader/-/cache-loader-4.1.0.tgz -> yarn-pkg--cache-loader-4.1.0.tgz
	https://registry.yarnpkg.com/call-bind/-/call-bind-1.0.0.tgz -> yarn-pkg--call-bind-1.0.0.tgz
	https://registry.yarnpkg.com/caller-callsite/-/caller-callsite-2.0.0.tgz -> yarn-pkg--caller-callsite-2.0.0.tgz
	https://registry.yarnpkg.com/caller-path/-/caller-path-2.0.0.tgz -> yarn-pkg--caller-path-2.0.0.tgz
	https://registry.yarnpkg.com/call-me-maybe/-/call-me-maybe-1.0.1.tgz -> yarn-pkg--call-me-maybe-1.0.1.tgz
	https://registry.yarnpkg.com/callsites/-/callsites-2.0.0.tgz -> yarn-pkg--callsites-2.0.0.tgz
	https://registry.yarnpkg.com/callsites/-/callsites-3.1.0.tgz -> yarn-pkg--callsites-3.1.0.tgz
	https://registry.yarnpkg.com/camel-case/-/camel-case-3.0.0.tgz -> yarn-pkg--camel-case-3.0.0.tgz
	https://registry.yarnpkg.com/camelcase/-/camelcase-5.3.1.tgz -> yarn-pkg--camelcase-5.3.1.tgz
	https://registry.yarnpkg.com/camelcase/-/camelcase-6.2.0.tgz -> yarn-pkg--camelcase-6.2.0.tgz
	https://registry.yarnpkg.com/caniuse-api/-/caniuse-api-3.0.0.tgz -> yarn-pkg--caniuse-api-3.0.0.tgz
	https://registry.yarnpkg.com/caniuse-lite/-/caniuse-lite-1.0.30001228.tgz -> yarn-pkg--caniuse-lite-1.0.30001228.tgz
	https://registry.yarnpkg.com/caseless/-/caseless-0.12.0.tgz -> yarn-pkg--caseless-0.12.0.tgz
	https://registry.yarnpkg.com/case-sensitive-paths-webpack-plugin/-/case-sensitive-paths-webpack-plugin-2.3.0.tgz -> yarn-pkg--case-sensitive-paths-webpack-plugin-2.3.0.tgz
	https://registry.yarnpkg.com/chalk/-/chalk-2.4.2.tgz -> yarn-pkg--chalk-2.4.2.tgz
	https://registry.yarnpkg.com/chalk/-/chalk-4.1.0.tgz -> yarn-pkg--chalk-4.1.0.tgz
	https://registry.yarnpkg.com/chardet/-/chardet-0.7.0.tgz -> yarn-pkg--chardet-0.7.0.tgz
	https://registry.yarnpkg.com/check-types/-/check-types-8.0.3.tgz -> yarn-pkg--check-types-8.0.3.tgz
	https://registry.yarnpkg.com/chokidar/-/chokidar-2.1.8.tgz -> yarn-pkg--chokidar-2.1.8.tgz
	https://registry.yarnpkg.com/chokidar/-/chokidar-3.5.0.tgz -> yarn-pkg--chokidar-3.5.0.tgz
	https://registry.yarnpkg.com/chownr/-/chownr-1.1.4.tgz -> yarn-pkg--chownr-1.1.4.tgz
	https://registry.yarnpkg.com/chrome-trace-event/-/chrome-trace-event-1.0.2.tgz -> yarn-pkg--chrome-trace-event-1.0.2.tgz
	https://registry.yarnpkg.com/ci-info/-/ci-info-1.6.0.tgz -> yarn-pkg--ci-info-1.6.0.tgz
	https://registry.yarnpkg.com/cipher-base/-/cipher-base-1.0.4.tgz -> yarn-pkg--cipher-base-1.0.4.tgz
	https://registry.yarnpkg.com/class-utils/-/class-utils-0.3.6.tgz -> yarn-pkg--class-utils-0.3.6.tgz
	https://registry.yarnpkg.com/clean-css/-/clean-css-4.2.3.tgz -> yarn-pkg--clean-css-4.2.3.tgz
	https://registry.yarnpkg.com/clean-stack/-/clean-stack-2.2.0.tgz -> yarn-pkg--clean-stack-2.2.0.tgz
	https://registry.yarnpkg.com/cli-cursor/-/cli-cursor-2.1.0.tgz -> yarn-pkg--cli-cursor-2.1.0.tgz
	https://registry.yarnpkg.com/cli-cursor/-/cli-cursor-3.1.0.tgz -> yarn-pkg--cli-cursor-3.1.0.tgz
	https://registry.yarnpkg.com/cli-highlight/-/cli-highlight-2.1.9.tgz -> yarn-pkg--cli-highlight-2.1.9.tgz
	https://registry.yarnpkg.com/clipboard/-/clipboard-2.0.6.tgz -> yarn-pkg--clipboard-2.0.6.tgz
	https://registry.yarnpkg.com/clipboardy/-/clipboardy-2.3.0.tgz -> yarn-pkg--clipboardy-2.3.0.tgz
	https://registry.yarnpkg.com/cli-spinners/-/cli-spinners-2.5.0.tgz -> yarn-pkg--cli-spinners-2.5.0.tgz
	https://registry.yarnpkg.com/cliui/-/cliui-5.0.0.tgz -> yarn-pkg--cliui-5.0.0.tgz
	https://registry.yarnpkg.com/cliui/-/cliui-6.0.0.tgz -> yarn-pkg--cliui-6.0.0.tgz
	https://registry.yarnpkg.com/cli-width/-/cli-width-2.2.1.tgz -> yarn-pkg--cli-width-2.2.1.tgz
	https://registry.yarnpkg.com/cli-width/-/cli-width-3.0.0.tgz -> yarn-pkg--cli-width-3.0.0.tgz
	https://registry.yarnpkg.com/clone/-/clone-1.0.4.tgz -> yarn-pkg--clone-1.0.4.tgz
	https://registry.yarnpkg.com/clone-deep/-/clone-deep-4.0.1.tgz -> yarn-pkg--clone-deep-4.0.1.tgz
	https://registry.yarnpkg.com/coa/-/coa-2.0.2.tgz -> yarn-pkg--coa-2.0.2.tgz
	https://registry.yarnpkg.com/collection-visit/-/collection-visit-1.0.0.tgz -> yarn-pkg--collection-visit-1.0.0.tgz
	https://registry.yarnpkg.com/color/-/color-3.1.3.tgz -> yarn-pkg--color-3.1.3.tgz
	https://registry.yarnpkg.com/color-convert/-/color-convert-1.9.3.tgz -> yarn-pkg--color-convert-1.9.3.tgz
	https://registry.yarnpkg.com/color-convert/-/color-convert-2.0.1.tgz -> yarn-pkg--color-convert-2.0.1.tgz
	https://registry.yarnpkg.com/colorette/-/colorette-1.2.2.tgz -> yarn-pkg--colorette-1.2.2.tgz
	https://registry.yarnpkg.com/color-name/-/color-name-1.1.3.tgz -> yarn-pkg--color-name-1.1.3.tgz
	https://registry.yarnpkg.com/color-name/-/color-name-1.1.4.tgz -> yarn-pkg--color-name-1.1.4.tgz
	https://registry.yarnpkg.com/color-string/-/color-string-1.6.0.tgz -> yarn-pkg--color-string-1.6.0.tgz
	https://registry.yarnpkg.com/combined-stream/-/combined-stream-1.0.8.tgz -> yarn-pkg--combined-stream-1.0.8.tgz
	https://registry.yarnpkg.com/commander/-/commander-2.13.0.tgz -> yarn-pkg--commander-2.13.0.tgz
	https://registry.yarnpkg.com/commander/-/commander-2.17.1.tgz -> yarn-pkg--commander-2.17.1.tgz
	https://registry.yarnpkg.com/commander/-/commander-2.19.0.tgz -> yarn-pkg--commander-2.19.0.tgz
	https://registry.yarnpkg.com/commander/-/commander-2.20.3.tgz -> yarn-pkg--commander-2.20.3.tgz
	https://registry.yarnpkg.com/commander/-/commander-5.1.0.tgz -> yarn-pkg--commander-5.1.0.tgz
	https://registry.yarnpkg.com/commondir/-/commondir-1.0.1.tgz -> yarn-pkg--commondir-1.0.1.tgz
	https://registry.yarnpkg.com/component-emitter/-/component-emitter-1.3.0.tgz -> yarn-pkg--component-emitter-1.3.0.tgz
	https://registry.yarnpkg.com/compressible/-/compressible-2.0.18.tgz -> yarn-pkg--compressible-2.0.18.tgz
	https://registry.yarnpkg.com/compression/-/compression-1.7.4.tgz -> yarn-pkg--compression-1.7.4.tgz
	https://registry.yarnpkg.com/concat-map/-/concat-map-0.0.1.tgz -> yarn-pkg--concat-map-0.0.1.tgz
	https://registry.yarnpkg.com/concat-stream/-/concat-stream-1.6.2.tgz -> yarn-pkg--concat-stream-1.6.2.tgz
	https://registry.yarnpkg.com/connect-history-api-fallback/-/connect-history-api-fallback-1.6.0.tgz -> yarn-pkg--connect-history-api-fallback-1.6.0.tgz
	https://registry.yarnpkg.com/console-browserify/-/console-browserify-1.2.0.tgz -> yarn-pkg--console-browserify-1.2.0.tgz
	https://registry.yarnpkg.com/consolidate/-/consolidate-0.15.1.tgz -> yarn-pkg--consolidate-0.15.1.tgz
	https://registry.yarnpkg.com/constants-browserify/-/constants-browserify-1.0.0.tgz -> yarn-pkg--constants-browserify-1.0.0.tgz
	https://registry.yarnpkg.com/content-disposition/-/content-disposition-0.5.3.tgz -> yarn-pkg--content-disposition-0.5.3.tgz
	https://registry.yarnpkg.com/content-type/-/content-type-1.0.4.tgz -> yarn-pkg--content-type-1.0.4.tgz
	https://registry.yarnpkg.com/convert-source-map/-/convert-source-map-1.7.0.tgz -> yarn-pkg--convert-source-map-1.7.0.tgz
	https://registry.yarnpkg.com/cookie/-/cookie-0.4.0.tgz -> yarn-pkg--cookie-0.4.0.tgz
	https://registry.yarnpkg.com/cookie-signature/-/cookie-signature-1.0.6.tgz -> yarn-pkg--cookie-signature-1.0.6.tgz
	https://registry.yarnpkg.com/copy-concurrently/-/copy-concurrently-1.0.5.tgz -> yarn-pkg--copy-concurrently-1.0.5.tgz
	https://registry.yarnpkg.com/copy-descriptor/-/copy-descriptor-0.1.1.tgz -> yarn-pkg--copy-descriptor-0.1.1.tgz
	https://registry.yarnpkg.com/copy-webpack-plugin/-/copy-webpack-plugin-5.1.2.tgz -> yarn-pkg--copy-webpack-plugin-5.1.2.tgz
	https://registry.yarnpkg.com/core-js-compat/-/core-js-compat-3.8.2.tgz -> yarn-pkg--core-js-compat-3.8.2.tgz
	https://registry.yarnpkg.com/core-js/-/core-js-3.8.2.tgz -> yarn-pkg--core-js-3.8.2.tgz
	https://registry.yarnpkg.com/core-util-is/-/core-util-is-1.0.2.tgz -> yarn-pkg--core-util-is-1.0.2.tgz
	https://registry.yarnpkg.com/cosmiconfig/-/cosmiconfig-5.2.1.tgz -> yarn-pkg--cosmiconfig-5.2.1.tgz
	https://registry.yarnpkg.com/create-ecdh/-/create-ecdh-4.0.4.tgz -> yarn-pkg--create-ecdh-4.0.4.tgz
	https://registry.yarnpkg.com/create-hash/-/create-hash-1.2.0.tgz -> yarn-pkg--create-hash-1.2.0.tgz
	https://registry.yarnpkg.com/create-hmac/-/create-hmac-1.1.7.tgz -> yarn-pkg--create-hmac-1.1.7.tgz
	https://registry.yarnpkg.com/cross-spawn/-/cross-spawn-5.1.0.tgz -> yarn-pkg--cross-spawn-5.1.0.tgz
	https://registry.yarnpkg.com/cross-spawn/-/cross-spawn-6.0.5.tgz -> yarn-pkg--cross-spawn-6.0.5.tgz
	https://registry.yarnpkg.com/cross-spawn/-/cross-spawn-7.0.3.tgz -> yarn-pkg--cross-spawn-7.0.3.tgz
	https://registry.yarnpkg.com/crypto-browserify/-/crypto-browserify-3.12.0.tgz -> yarn-pkg--crypto-browserify-3.12.0.tgz
	https://registry.yarnpkg.com/css-color-names/-/css-color-names-0.0.4.tgz -> yarn-pkg--css-color-names-0.0.4.tgz
	https://registry.yarnpkg.com/css-declaration-sorter/-/css-declaration-sorter-4.0.1.tgz -> yarn-pkg--css-declaration-sorter-4.0.1.tgz
	https://registry.yarnpkg.com/cssesc/-/cssesc-3.0.0.tgz -> yarn-pkg--cssesc-3.0.0.tgz
	https://registry.yarnpkg.com/css-loader/-/css-loader-3.6.0.tgz -> yarn-pkg--css-loader-3.6.0.tgz
	https://registry.yarnpkg.com/cssnano/-/cssnano-4.1.10.tgz -> yarn-pkg--cssnano-4.1.10.tgz
	https://registry.yarnpkg.com/cssnano-preset-default/-/cssnano-preset-default-4.0.7.tgz -> yarn-pkg--cssnano-preset-default-4.0.7.tgz
	https://registry.yarnpkg.com/cssnano-util-get-arguments/-/cssnano-util-get-arguments-4.0.0.tgz -> yarn-pkg--cssnano-util-get-arguments-4.0.0.tgz
	https://registry.yarnpkg.com/cssnano-util-get-match/-/cssnano-util-get-match-4.0.0.tgz -> yarn-pkg--cssnano-util-get-match-4.0.0.tgz
	https://registry.yarnpkg.com/cssnano-util-raw-cache/-/cssnano-util-raw-cache-4.0.1.tgz -> yarn-pkg--cssnano-util-raw-cache-4.0.1.tgz
	https://registry.yarnpkg.com/cssnano-util-same-parent/-/cssnano-util-same-parent-4.0.1.tgz -> yarn-pkg--cssnano-util-same-parent-4.0.1.tgz
	https://registry.yarnpkg.com/csso/-/csso-4.2.0.tgz -> yarn-pkg--csso-4.2.0.tgz
	https://registry.yarnpkg.com/css-select-base-adapter/-/css-select-base-adapter-0.1.1.tgz -> yarn-pkg--css-select-base-adapter-0.1.1.tgz
	https://registry.yarnpkg.com/css-select/-/css-select-2.1.0.tgz -> yarn-pkg--css-select-2.1.0.tgz
	https://registry.yarnpkg.com/css-tree/-/css-tree-1.0.0-alpha.37.tgz -> yarn-pkg--css-tree-1.0.0-alpha.37.tgz
	https://registry.yarnpkg.com/css-tree/-/css-tree-1.1.2.tgz -> yarn-pkg--css-tree-1.1.2.tgz
	https://registry.yarnpkg.com/css-what/-/css-what-3.4.2.tgz -> yarn-pkg--css-what-3.4.2.tgz
	https://registry.yarnpkg.com/cubic2quad/-/cubic2quad-1.1.1.tgz -> yarn-pkg--cubic2quad-1.1.1.tgz
	https://registry.yarnpkg.com/cyclist/-/cyclist-1.0.1.tgz -> yarn-pkg--cyclist-1.0.1.tgz
	https://registry.yarnpkg.com/dashdash/-/dashdash-1.14.1.tgz -> yarn-pkg--dashdash-1.14.1.tgz
	https://registry.yarnpkg.com/debug/-/debug-2.6.9.tgz -> yarn-pkg--debug-2.6.9.tgz
	https://registry.yarnpkg.com/debug/-/debug-3.2.7.tgz -> yarn-pkg--debug-3.2.7.tgz
	https://registry.yarnpkg.com/debug/-/debug-4.3.1.tgz -> yarn-pkg--debug-4.3.1.tgz
	https://registry.yarnpkg.com/decamelize/-/decamelize-1.2.0.tgz -> yarn-pkg--decamelize-1.2.0.tgz
	https://registry.yarnpkg.com/decode-uri-component/-/decode-uri-component-0.2.0.tgz -> yarn-pkg--decode-uri-component-0.2.0.tgz
	https://registry.yarnpkg.com/deep-equal/-/deep-equal-1.1.1.tgz -> yarn-pkg--deep-equal-1.1.1.tgz
	https://registry.yarnpkg.com/deep-is/-/deep-is-0.1.3.tgz -> yarn-pkg--deep-is-0.1.3.tgz
	https://registry.yarnpkg.com/deepmerge/-/deepmerge-1.5.2.tgz -> yarn-pkg--deepmerge-1.5.2.tgz
	https://registry.yarnpkg.com/default-gateway/-/default-gateway-4.2.0.tgz -> yarn-pkg--default-gateway-4.2.0.tgz
	https://registry.yarnpkg.com/default-gateway/-/default-gateway-5.0.5.tgz -> yarn-pkg--default-gateway-5.0.5.tgz
	https://registry.yarnpkg.com/defaults/-/defaults-1.0.3.tgz -> yarn-pkg--defaults-1.0.3.tgz
	https://registry.yarnpkg.com/define-properties/-/define-properties-1.1.3.tgz -> yarn-pkg--define-properties-1.1.3.tgz
	https://registry.yarnpkg.com/define-property/-/define-property-0.2.5.tgz -> yarn-pkg--define-property-0.2.5.tgz
	https://registry.yarnpkg.com/define-property/-/define-property-1.0.0.tgz -> yarn-pkg--define-property-1.0.0.tgz
	https://registry.yarnpkg.com/define-property/-/define-property-2.0.2.tgz -> yarn-pkg--define-property-2.0.2.tgz
	https://registry.yarnpkg.com/de-indent/-/de-indent-1.0.2.tgz -> yarn-pkg--de-indent-1.0.2.tgz
	https://registry.yarnpkg.com/delayed-stream/-/delayed-stream-1.0.0.tgz -> yarn-pkg--delayed-stream-1.0.0.tgz
	https://registry.yarnpkg.com/del/-/del-4.1.1.tgz -> yarn-pkg--del-4.1.1.tgz
	https://registry.yarnpkg.com/delegate/-/delegate-3.2.0.tgz -> yarn-pkg--delegate-3.2.0.tgz
	https://registry.yarnpkg.com/depd/-/depd-1.1.2.tgz -> yarn-pkg--depd-1.1.2.tgz
	https://registry.yarnpkg.com/des.js/-/des.js-1.0.1.tgz -> yarn-pkg--des.js-1.0.1.tgz
	https://registry.yarnpkg.com/destroy/-/destroy-1.0.4.tgz -> yarn-pkg--destroy-1.0.4.tgz
	https://registry.yarnpkg.com/detect-node/-/detect-node-2.0.4.tgz -> yarn-pkg--detect-node-2.0.4.tgz
	https://registry.yarnpkg.com/diffie-hellman/-/diffie-hellman-5.0.3.tgz -> yarn-pkg--diffie-hellman-5.0.3.tgz
	https://registry.yarnpkg.com/dijkstrajs/-/dijkstrajs-1.0.1.tgz -> yarn-pkg--dijkstrajs-1.0.1.tgz
	https://registry.yarnpkg.com/dir-glob/-/dir-glob-2.0.0.tgz -> yarn-pkg--dir-glob-2.0.0.tgz
	https://registry.yarnpkg.com/dir-glob/-/dir-glob-2.2.2.tgz -> yarn-pkg--dir-glob-2.2.2.tgz
	https://registry.yarnpkg.com/dns-equal/-/dns-equal-1.0.0.tgz -> yarn-pkg--dns-equal-1.0.0.tgz
	https://registry.yarnpkg.com/dns-packet/-/dns-packet-1.3.4.tgz -> yarn-pkg--dns-packet-1.3.4.tgz
	https://registry.yarnpkg.com/dns-txt/-/dns-txt-2.0.2.tgz -> yarn-pkg--dns-txt-2.0.2.tgz
	https://registry.yarnpkg.com/doctrine/-/doctrine-3.0.0.tgz -> yarn-pkg--doctrine-3.0.0.tgz
	https://registry.yarnpkg.com/domain-browser/-/domain-browser-1.2.0.tgz -> yarn-pkg--domain-browser-1.2.0.tgz
	https://registry.yarnpkg.com/dom-converter/-/dom-converter-0.2.0.tgz -> yarn-pkg--dom-converter-0.2.0.tgz
	https://registry.yarnpkg.com/domelementtype/-/domelementtype-1.3.1.tgz -> yarn-pkg--domelementtype-1.3.1.tgz
	https://registry.yarnpkg.com/domelementtype/-/domelementtype-2.1.0.tgz -> yarn-pkg--domelementtype-2.1.0.tgz
	https://registry.yarnpkg.com/domhandler/-/domhandler-2.4.2.tgz -> yarn-pkg--domhandler-2.4.2.tgz
	https://registry.yarnpkg.com/dom-serializer/-/dom-serializer-0.2.2.tgz -> yarn-pkg--dom-serializer-0.2.2.tgz
	https://registry.yarnpkg.com/domutils/-/domutils-1.7.0.tgz -> yarn-pkg--domutils-1.7.0.tgz
	https://registry.yarnpkg.com/dotenv/-/dotenv-8.2.0.tgz -> yarn-pkg--dotenv-8.2.0.tgz
	https://registry.yarnpkg.com/dotenv-expand/-/dotenv-expand-5.1.0.tgz -> yarn-pkg--dotenv-expand-5.1.0.tgz
	https://registry.yarnpkg.com/dot-prop/-/dot-prop-5.3.0.tgz -> yarn-pkg--dot-prop-5.3.0.tgz
	https://registry.yarnpkg.com/duplexer/-/duplexer-0.1.2.tgz -> yarn-pkg--duplexer-0.1.2.tgz
	https://registry.yarnpkg.com/duplexify/-/duplexify-3.7.1.tgz -> yarn-pkg--duplexify-3.7.1.tgz
	https://registry.yarnpkg.com/easy-stack/-/easy-stack-1.0.1.tgz -> yarn-pkg--easy-stack-1.0.1.tgz
	https://registry.yarnpkg.com/ecc-jsbn/-/ecc-jsbn-0.1.2.tgz -> yarn-pkg--ecc-jsbn-0.1.2.tgz
	https://registry.yarnpkg.com/ee-first/-/ee-first-1.1.1.tgz -> yarn-pkg--ee-first-1.1.1.tgz
	https://registry.yarnpkg.com/ejs/-/ejs-2.7.4.tgz -> yarn-pkg--ejs-2.7.4.tgz
	https://registry.yarnpkg.com/electron-to-chromium/-/electron-to-chromium-1.3.738.tgz -> yarn-pkg--electron-to-chromium-1.3.738.tgz
	https://registry.yarnpkg.com/elliptic/-/elliptic-6.5.4.tgz -> yarn-pkg--elliptic-6.5.4.tgz
	https://registry.yarnpkg.com/emoji-regex/-/emoji-regex-7.0.3.tgz -> yarn-pkg--emoji-regex-7.0.3.tgz
	https://registry.yarnpkg.com/emoji-regex/-/emoji-regex-8.0.0.tgz -> yarn-pkg--emoji-regex-8.0.0.tgz
	https://registry.yarnpkg.com/emojis-list/-/emojis-list-2.1.0.tgz -> yarn-pkg--emojis-list-2.1.0.tgz
	https://registry.yarnpkg.com/emojis-list/-/emojis-list-3.0.0.tgz -> yarn-pkg--emojis-list-3.0.0.tgz
	https://registry.yarnpkg.com/encodeurl/-/encodeurl-1.0.2.tgz -> yarn-pkg--encodeurl-1.0.2.tgz
	https://registry.yarnpkg.com/end-of-stream/-/end-of-stream-1.4.4.tgz -> yarn-pkg--end-of-stream-1.4.4.tgz
	https://registry.yarnpkg.com/enhanced-resolve/-/enhanced-resolve-4.3.0.tgz -> yarn-pkg--enhanced-resolve-4.3.0.tgz
	https://registry.yarnpkg.com/entities/-/entities-1.1.2.tgz -> yarn-pkg--entities-1.1.2.tgz
	https://registry.yarnpkg.com/entities/-/entities-2.1.0.tgz -> yarn-pkg--entities-2.1.0.tgz
	https://registry.yarnpkg.com/errno/-/errno-0.1.8.tgz -> yarn-pkg--errno-0.1.8.tgz
	https://registry.yarnpkg.com/error-ex/-/error-ex-1.3.2.tgz -> yarn-pkg--error-ex-1.3.2.tgz
	https://registry.yarnpkg.com/error-stack-parser/-/error-stack-parser-2.0.6.tgz -> yarn-pkg--error-stack-parser-2.0.6.tgz
	https://registry.yarnpkg.com/es-abstract/-/es-abstract-1.17.7.tgz -> yarn-pkg--es-abstract-1.17.7.tgz
	https://registry.yarnpkg.com/es-abstract/-/es-abstract-1.18.0-next.1.tgz -> yarn-pkg--es-abstract-1.18.0-next.1.tgz
	https://registry.yarnpkg.com/escalade/-/escalade-3.1.1.tgz -> yarn-pkg--escalade-3.1.1.tgz
	https://registry.yarnpkg.com/escape-html/-/escape-html-1.0.3.tgz -> yarn-pkg--escape-html-1.0.3.tgz
	https://registry.yarnpkg.com/escape-string-regexp/-/escape-string-regexp-1.0.5.tgz -> yarn-pkg--escape-string-regexp-1.0.5.tgz
	https://registry.yarnpkg.com/eslint-config-prettier/-/eslint-config-prettier-6.15.0.tgz -> yarn-pkg--eslint-config-prettier-6.15.0.tgz
	https://registry.yarnpkg.com/eslint/-/eslint-5.16.0.tgz -> yarn-pkg--eslint-5.16.0.tgz
	https://registry.yarnpkg.com/eslint-loader/-/eslint-loader-2.2.1.tgz -> yarn-pkg--eslint-loader-2.2.1.tgz
	https://registry.yarnpkg.com/eslint-plugin-prettier/-/eslint-plugin-prettier-3.3.1.tgz -> yarn-pkg--eslint-plugin-prettier-3.3.1.tgz
	https://registry.yarnpkg.com/eslint-plugin-vue/-/eslint-plugin-vue-5.2.3.tgz -> yarn-pkg--eslint-plugin-vue-5.2.3.tgz
	https://registry.yarnpkg.com/eslint-scope/-/eslint-scope-4.0.3.tgz -> yarn-pkg--eslint-scope-4.0.3.tgz
	https://registry.yarnpkg.com/eslint-utils/-/eslint-utils-1.4.3.tgz -> yarn-pkg--eslint-utils-1.4.3.tgz
	https://registry.yarnpkg.com/eslint-visitor-keys/-/eslint-visitor-keys-1.3.0.tgz -> yarn-pkg--eslint-visitor-keys-1.3.0.tgz
	https://registry.yarnpkg.com/espree/-/espree-4.1.0.tgz -> yarn-pkg--espree-4.1.0.tgz
	https://registry.yarnpkg.com/espree/-/espree-5.0.1.tgz -> yarn-pkg--espree-5.0.1.tgz
	https://registry.yarnpkg.com/esprima/-/esprima-4.0.1.tgz -> yarn-pkg--esprima-4.0.1.tgz
	https://registry.yarnpkg.com/esquery/-/esquery-1.3.1.tgz -> yarn-pkg--esquery-1.3.1.tgz
	https://registry.yarnpkg.com/esrecurse/-/esrecurse-4.3.0.tgz -> yarn-pkg--esrecurse-4.3.0.tgz
	https://registry.yarnpkg.com/es-to-primitive/-/es-to-primitive-1.2.1.tgz -> yarn-pkg--es-to-primitive-1.2.1.tgz
	https://registry.yarnpkg.com/estraverse/-/estraverse-4.3.0.tgz -> yarn-pkg--estraverse-4.3.0.tgz
	https://registry.yarnpkg.com/estraverse/-/estraverse-5.2.0.tgz -> yarn-pkg--estraverse-5.2.0.tgz
	https://registry.yarnpkg.com/esutils/-/esutils-2.0.3.tgz -> yarn-pkg--esutils-2.0.3.tgz
	https://registry.yarnpkg.com/etag/-/etag-1.8.1.tgz -> yarn-pkg--etag-1.8.1.tgz
	https://registry.yarnpkg.com/eventemitter3/-/eventemitter3-4.0.7.tgz -> yarn-pkg--eventemitter3-4.0.7.tgz
	https://registry.yarnpkg.com/event-pubsub/-/event-pubsub-4.3.0.tgz -> yarn-pkg--event-pubsub-4.3.0.tgz
	https://registry.yarnpkg.com/events/-/events-3.2.0.tgz -> yarn-pkg--events-3.2.0.tgz
	https://registry.yarnpkg.com/eventsource/-/eventsource-1.0.7.tgz -> yarn-pkg--eventsource-1.0.7.tgz
	https://registry.yarnpkg.com/evp_bytestokey/-/evp_bytestokey-1.0.3.tgz -> yarn-pkg--evp_bytestokey-1.0.3.tgz
	https://registry.yarnpkg.com/execa/-/execa-0.8.0.tgz -> yarn-pkg--execa-0.8.0.tgz
	https://registry.yarnpkg.com/execa/-/execa-1.0.0.tgz -> yarn-pkg--execa-1.0.0.tgz
	https://registry.yarnpkg.com/execa/-/execa-3.4.0.tgz -> yarn-pkg--execa-3.4.0.tgz
	https://registry.yarnpkg.com/expand-brackets/-/expand-brackets-2.1.4.tgz -> yarn-pkg--expand-brackets-2.1.4.tgz
	https://registry.yarnpkg.com/express/-/express-4.17.1.tgz -> yarn-pkg--express-4.17.1.tgz
	https://registry.yarnpkg.com/extend/-/extend-3.0.2.tgz -> yarn-pkg--extend-3.0.2.tgz
	https://registry.yarnpkg.com/extend-shallow/-/extend-shallow-2.0.1.tgz -> yarn-pkg--extend-shallow-2.0.1.tgz
	https://registry.yarnpkg.com/extend-shallow/-/extend-shallow-3.0.2.tgz -> yarn-pkg--extend-shallow-3.0.2.tgz
	https://registry.yarnpkg.com/external-editor/-/external-editor-3.1.0.tgz -> yarn-pkg--external-editor-3.1.0.tgz
	https://registry.yarnpkg.com/extglob/-/extglob-2.0.4.tgz -> yarn-pkg--extglob-2.0.4.tgz
	https://registry.yarnpkg.com/extsprintf/-/extsprintf-1.3.0.tgz -> yarn-pkg--extsprintf-1.3.0.tgz
	https://registry.yarnpkg.com/extsprintf/-/extsprintf-1.4.0.tgz -> yarn-pkg--extsprintf-1.4.0.tgz
	https://registry.yarnpkg.com/fast-deep-equal/-/fast-deep-equal-3.1.3.tgz -> yarn-pkg--fast-deep-equal-3.1.3.tgz
	https://registry.yarnpkg.com/fast-diff/-/fast-diff-1.2.0.tgz -> yarn-pkg--fast-diff-1.2.0.tgz
	https://registry.yarnpkg.com/fast-glob/-/fast-glob-2.2.7.tgz -> yarn-pkg--fast-glob-2.2.7.tgz
	https://registry.yarnpkg.com/fast-json-stable-stringify/-/fast-json-stable-stringify-2.1.0.tgz -> yarn-pkg--fast-json-stable-stringify-2.1.0.tgz
	https://registry.yarnpkg.com/fast-levenshtein/-/fast-levenshtein-2.0.6.tgz -> yarn-pkg--fast-levenshtein-2.0.6.tgz
	https://registry.yarnpkg.com/faye-websocket/-/faye-websocket-0.11.3.tgz -> yarn-pkg--faye-websocket-0.11.3.tgz
	https://registry.yarnpkg.com/figgy-pudding/-/figgy-pudding-3.5.2.tgz -> yarn-pkg--figgy-pudding-3.5.2.tgz
	https://registry.yarnpkg.com/figures/-/figures-2.0.0.tgz -> yarn-pkg--figures-2.0.0.tgz
	https://registry.yarnpkg.com/figures/-/figures-3.2.0.tgz -> yarn-pkg--figures-3.2.0.tgz
	https://registry.yarnpkg.com/file-entry-cache/-/file-entry-cache-5.0.1.tgz -> yarn-pkg--file-entry-cache-5.0.1.tgz
	https://registry.yarnpkg.com/file-loader/-/file-loader-4.3.0.tgz -> yarn-pkg--file-loader-4.3.0.tgz
	https://registry.yarnpkg.com/filesize/-/filesize-3.6.1.tgz -> yarn-pkg--filesize-3.6.1.tgz
	https://registry.yarnpkg.com/file-uri-to-path/-/file-uri-to-path-1.0.0.tgz -> yarn-pkg--file-uri-to-path-1.0.0.tgz
	https://registry.yarnpkg.com/fill-range/-/fill-range-4.0.0.tgz -> yarn-pkg--fill-range-4.0.0.tgz
	https://registry.yarnpkg.com/fill-range/-/fill-range-7.0.1.tgz -> yarn-pkg--fill-range-7.0.1.tgz
	https://registry.yarnpkg.com/finalhandler/-/finalhandler-1.1.2.tgz -> yarn-pkg--finalhandler-1.1.2.tgz
	https://registry.yarnpkg.com/find-cache-dir/-/find-cache-dir-0.1.1.tgz -> yarn-pkg--find-cache-dir-0.1.1.tgz
	https://registry.yarnpkg.com/find-cache-dir/-/find-cache-dir-1.0.0.tgz -> yarn-pkg--find-cache-dir-1.0.0.tgz
	https://registry.yarnpkg.com/find-cache-dir/-/find-cache-dir-2.1.0.tgz -> yarn-pkg--find-cache-dir-2.1.0.tgz
	https://registry.yarnpkg.com/find-cache-dir/-/find-cache-dir-3.3.1.tgz -> yarn-pkg--find-cache-dir-3.3.1.tgz
	https://registry.yarnpkg.com/find-up/-/find-up-1.1.2.tgz -> yarn-pkg--find-up-1.1.2.tgz
	https://registry.yarnpkg.com/find-up/-/find-up-2.1.0.tgz -> yarn-pkg--find-up-2.1.0.tgz
	https://registry.yarnpkg.com/find-up/-/find-up-3.0.0.tgz -> yarn-pkg--find-up-3.0.0.tgz
	https://registry.yarnpkg.com/find-up/-/find-up-4.1.0.tgz -> yarn-pkg--find-up-4.1.0.tgz
	https://registry.yarnpkg.com/flat-cache/-/flat-cache-2.0.1.tgz -> yarn-pkg--flat-cache-2.0.1.tgz
	https://registry.yarnpkg.com/flatted/-/flatted-2.0.2.tgz -> yarn-pkg--flatted-2.0.2.tgz
	https://registry.yarnpkg.com/flush-write-stream/-/flush-write-stream-1.1.1.tgz -> yarn-pkg--flush-write-stream-1.1.1.tgz
	https://registry.yarnpkg.com/follow-redirects/-/follow-redirects-1.13.1.tgz -> yarn-pkg--follow-redirects-1.13.1.tgz
	https://registry.yarnpkg.com/forever-agent/-/forever-agent-0.6.1.tgz -> yarn-pkg--forever-agent-0.6.1.tgz
	https://registry.yarnpkg.com/for-in/-/for-in-1.0.2.tgz -> yarn-pkg--for-in-1.0.2.tgz
	https://registry.yarnpkg.com/form-data/-/form-data-2.3.3.tgz -> yarn-pkg--form-data-2.3.3.tgz
	https://registry.yarnpkg.com/forwarded/-/forwarded-0.1.2.tgz -> yarn-pkg--forwarded-0.1.2.tgz
	https://registry.yarnpkg.com/fragment-cache/-/fragment-cache-0.2.1.tgz -> yarn-pkg--fragment-cache-0.2.1.tgz
	https://registry.yarnpkg.com/fresh/-/fresh-0.5.2.tgz -> yarn-pkg--fresh-0.5.2.tgz
	https://registry.yarnpkg.com/from2/-/from2-2.3.0.tgz -> yarn-pkg--from2-2.3.0.tgz
	https://registry.yarnpkg.com/fsevents/-/fsevents-1.2.13.tgz -> yarn-pkg--fsevents-1.2.13.tgz
	https://registry.yarnpkg.com/fsevents/-/fsevents-2.3.1.tgz -> yarn-pkg--fsevents-2.3.1.tgz
	https://registry.yarnpkg.com/fs-extra/-/fs-extra-7.0.1.tgz -> yarn-pkg--fs-extra-7.0.1.tgz
	https://registry.yarnpkg.com/fs-minipass/-/fs-minipass-2.1.0.tgz -> yarn-pkg--fs-minipass-2.1.0.tgz
	https://registry.yarnpkg.com/fs.realpath/-/fs.realpath-1.0.0.tgz -> yarn-pkg--fs.realpath-1.0.0.tgz
	https://registry.yarnpkg.com/fs-write-stream-atomic/-/fs-write-stream-atomic-1.0.10.tgz -> yarn-pkg--fs-write-stream-atomic-1.0.10.tgz
	https://registry.yarnpkg.com/functional-red-black-tree/-/functional-red-black-tree-1.0.1.tgz -> yarn-pkg--functional-red-black-tree-1.0.1.tgz
	https://registry.yarnpkg.com/function-bind/-/function-bind-1.1.1.tgz -> yarn-pkg--function-bind-1.1.1.tgz
	https://registry.yarnpkg.com/gensync/-/gensync-1.0.0-beta.2.tgz -> yarn-pkg--gensync-1.0.0-beta.2.tgz
	https://registry.yarnpkg.com/geometry-interfaces/-/geometry-interfaces-1.1.4.tgz -> yarn-pkg--geometry-interfaces-1.1.4.tgz
	https://registry.yarnpkg.com/get-caller-file/-/get-caller-file-2.0.5.tgz -> yarn-pkg--get-caller-file-2.0.5.tgz
	https://registry.yarnpkg.com/get-intrinsic/-/get-intrinsic-1.0.2.tgz -> yarn-pkg--get-intrinsic-1.0.2.tgz
	https://registry.yarnpkg.com/getpass/-/getpass-0.1.7.tgz -> yarn-pkg--getpass-0.1.7.tgz
	https://registry.yarnpkg.com/get-stdin/-/get-stdin-6.0.0.tgz -> yarn-pkg--get-stdin-6.0.0.tgz
	https://registry.yarnpkg.com/get-stream/-/get-stream-3.0.0.tgz -> yarn-pkg--get-stream-3.0.0.tgz
	https://registry.yarnpkg.com/get-stream/-/get-stream-4.1.0.tgz -> yarn-pkg--get-stream-4.1.0.tgz
	https://registry.yarnpkg.com/get-stream/-/get-stream-5.2.0.tgz -> yarn-pkg--get-stream-5.2.0.tgz
	https://registry.yarnpkg.com/get-value/-/get-value-2.0.6.tgz -> yarn-pkg--get-value-2.0.6.tgz
	https://registry.yarnpkg.com/globals/-/globals-11.12.0.tgz -> yarn-pkg--globals-11.12.0.tgz
	https://registry.yarnpkg.com/globby/-/globby-6.1.0.tgz -> yarn-pkg--globby-6.1.0.tgz
	https://registry.yarnpkg.com/globby/-/globby-7.1.1.tgz -> yarn-pkg--globby-7.1.1.tgz
	https://registry.yarnpkg.com/globby/-/globby-8.0.2.tgz -> yarn-pkg--globby-8.0.2.tgz
	https://registry.yarnpkg.com/globby/-/globby-9.2.0.tgz -> yarn-pkg--globby-9.2.0.tgz
	https://registry.yarnpkg.com/glob/-/glob-7.1.6.tgz -> yarn-pkg--glob-7.1.6.tgz
	https://registry.yarnpkg.com/glob-parent/-/glob-parent-3.1.0.tgz -> yarn-pkg--glob-parent-3.1.0.tgz
	https://registry.yarnpkg.com/glob-parent/-/glob-parent-5.1.1.tgz -> yarn-pkg--glob-parent-5.1.1.tgz
	https://registry.yarnpkg.com/glob-to-regexp/-/glob-to-regexp-0.3.0.tgz -> yarn-pkg--glob-to-regexp-0.3.0.tgz
	https://registry.yarnpkg.com/good-listener/-/good-listener-1.2.2.tgz -> yarn-pkg--good-listener-1.2.2.tgz
	https://registry.yarnpkg.com/graceful-fs/-/graceful-fs-4.2.4.tgz -> yarn-pkg--graceful-fs-4.2.4.tgz
	https://registry.yarnpkg.com/gzip-size/-/gzip-size-5.1.1.tgz -> yarn-pkg--gzip-size-5.1.1.tgz
	https://registry.yarnpkg.com/handle-thing/-/handle-thing-2.0.1.tgz -> yarn-pkg--handle-thing-2.0.1.tgz
	https://registry.yarnpkg.com/@hapi/address/-/address-2.1.4.tgz -> yarn-pkg-@hapi-address-2.1.4.tgz
	https://registry.yarnpkg.com/@hapi/bourne/-/bourne-1.3.2.tgz -> yarn-pkg-@hapi-bourne-1.3.2.tgz
	https://registry.yarnpkg.com/@hapi/hoek/-/hoek-8.5.1.tgz -> yarn-pkg-@hapi-hoek-8.5.1.tgz
	https://registry.yarnpkg.com/@hapi/joi/-/joi-15.1.1.tgz -> yarn-pkg-@hapi-joi-15.1.1.tgz
	https://registry.yarnpkg.com/@hapi/topo/-/topo-3.1.6.tgz -> yarn-pkg-@hapi-topo-3.1.6.tgz
	https://registry.yarnpkg.com/har-schema/-/har-schema-2.0.0.tgz -> yarn-pkg--har-schema-2.0.0.tgz
	https://registry.yarnpkg.com/har-validator/-/har-validator-5.1.5.tgz -> yarn-pkg--har-validator-5.1.5.tgz
	https://registry.yarnpkg.com/has-flag/-/has-flag-3.0.0.tgz -> yarn-pkg--has-flag-3.0.0.tgz
	https://registry.yarnpkg.com/has-flag/-/has-flag-4.0.0.tgz -> yarn-pkg--has-flag-4.0.0.tgz
	https://registry.yarnpkg.com/has/-/has-1.0.3.tgz -> yarn-pkg--has-1.0.3.tgz
	https://registry.yarnpkg.com/hash-base/-/hash-base-3.1.0.tgz -> yarn-pkg--hash-base-3.1.0.tgz
	https://registry.yarnpkg.com/hash.js/-/hash.js-1.1.7.tgz -> yarn-pkg--hash.js-1.1.7.tgz
	https://registry.yarnpkg.com/hash-sum/-/hash-sum-1.0.2.tgz -> yarn-pkg--hash-sum-1.0.2.tgz
	https://registry.yarnpkg.com/hash-sum/-/hash-sum-2.0.0.tgz -> yarn-pkg--hash-sum-2.0.0.tgz
	https://registry.yarnpkg.com/has-symbols/-/has-symbols-1.0.1.tgz -> yarn-pkg--has-symbols-1.0.1.tgz
	https://registry.yarnpkg.com/has-value/-/has-value-0.3.1.tgz -> yarn-pkg--has-value-0.3.1.tgz
	https://registry.yarnpkg.com/has-value/-/has-value-1.0.0.tgz -> yarn-pkg--has-value-1.0.0.tgz
	https://registry.yarnpkg.com/has-values/-/has-values-0.1.4.tgz -> yarn-pkg--has-values-0.1.4.tgz
	https://registry.yarnpkg.com/has-values/-/has-values-1.0.0.tgz -> yarn-pkg--has-values-1.0.0.tgz
	https://registry.yarnpkg.com/he/-/he-1.2.0.tgz -> yarn-pkg--he-1.2.0.tgz
	https://registry.yarnpkg.com/hex-color-regex/-/hex-color-regex-1.1.0.tgz -> yarn-pkg--hex-color-regex-1.1.0.tgz
	https://registry.yarnpkg.com/highlight.js/-/highlight.js-10.5.0.tgz -> yarn-pkg--highlight.js-10.5.0.tgz
	https://registry.yarnpkg.com/hmac-drbg/-/hmac-drbg-1.0.1.tgz -> yarn-pkg--hmac-drbg-1.0.1.tgz
	https://registry.yarnpkg.com/hoopy/-/hoopy-0.1.4.tgz -> yarn-pkg--hoopy-0.1.4.tgz
	https://registry.yarnpkg.com/hosted-git-info/-/hosted-git-info-2.8.9.tgz -> yarn-pkg--hosted-git-info-2.8.9.tgz
	https://registry.yarnpkg.com/hpack.js/-/hpack.js-2.1.6.tgz -> yarn-pkg--hpack.js-2.1.6.tgz
	https://registry.yarnpkg.com/hsla-regex/-/hsla-regex-1.0.0.tgz -> yarn-pkg--hsla-regex-1.0.0.tgz
	https://registry.yarnpkg.com/hsl-regex/-/hsl-regex-1.0.0.tgz -> yarn-pkg--hsl-regex-1.0.0.tgz
	https://registry.yarnpkg.com/html-comment-regex/-/html-comment-regex-1.1.2.tgz -> yarn-pkg--html-comment-regex-1.1.2.tgz
	https://registry.yarnpkg.com/html-entities/-/html-entities-1.4.0.tgz -> yarn-pkg--html-entities-1.4.0.tgz
	https://registry.yarnpkg.com/html-minifier/-/html-minifier-3.5.21.tgz -> yarn-pkg--html-minifier-3.5.21.tgz
	https://registry.yarnpkg.com/htmlparser2/-/htmlparser2-3.10.1.tgz -> yarn-pkg--htmlparser2-3.10.1.tgz
	https://registry.yarnpkg.com/html-tags/-/html-tags-2.0.0.tgz -> yarn-pkg--html-tags-2.0.0.tgz
	https://registry.yarnpkg.com/html-tags/-/html-tags-3.1.0.tgz -> yarn-pkg--html-tags-3.1.0.tgz
	https://registry.yarnpkg.com/html-webpack-plugin/-/html-webpack-plugin-3.2.0.tgz -> yarn-pkg--html-webpack-plugin-3.2.0.tgz
	https://registry.yarnpkg.com/http-deceiver/-/http-deceiver-1.2.7.tgz -> yarn-pkg--http-deceiver-1.2.7.tgz
	https://registry.yarnpkg.com/http-errors/-/http-errors-1.6.3.tgz -> yarn-pkg--http-errors-1.6.3.tgz
	https://registry.yarnpkg.com/http-errors/-/http-errors-1.7.2.tgz -> yarn-pkg--http-errors-1.7.2.tgz
	https://registry.yarnpkg.com/http-errors/-/http-errors-1.7.3.tgz -> yarn-pkg--http-errors-1.7.3.tgz
	https://registry.yarnpkg.com/http-parser-js/-/http-parser-js-0.5.3.tgz -> yarn-pkg--http-parser-js-0.5.3.tgz
	https://registry.yarnpkg.com/http-proxy/-/http-proxy-1.18.1.tgz -> yarn-pkg--http-proxy-1.18.1.tgz
	https://registry.yarnpkg.com/http-proxy-middleware/-/http-proxy-middleware-0.19.1.tgz -> yarn-pkg--http-proxy-middleware-0.19.1.tgz
	https://registry.yarnpkg.com/https-browserify/-/https-browserify-1.0.0.tgz -> yarn-pkg--https-browserify-1.0.0.tgz
	https://registry.yarnpkg.com/http-signature/-/http-signature-1.2.0.tgz -> yarn-pkg--http-signature-1.2.0.tgz
	https://registry.yarnpkg.com/human-signals/-/human-signals-1.1.1.tgz -> yarn-pkg--human-signals-1.1.1.tgz
	https://registry.yarnpkg.com/iconv-lite/-/iconv-lite-0.4.24.tgz -> yarn-pkg--iconv-lite-0.4.24.tgz
	https://registry.yarnpkg.com/icss-utils/-/icss-utils-4.1.1.tgz -> yarn-pkg--icss-utils-4.1.1.tgz
	https://registry.yarnpkg.com/ieee754/-/ieee754-1.2.1.tgz -> yarn-pkg--ieee754-1.2.1.tgz
	https://registry.yarnpkg.com/iferr/-/iferr-0.1.5.tgz -> yarn-pkg--iferr-0.1.5.tgz
	https://registry.yarnpkg.com/ignore/-/ignore-3.3.10.tgz -> yarn-pkg--ignore-3.3.10.tgz
	https://registry.yarnpkg.com/ignore/-/ignore-4.0.6.tgz -> yarn-pkg--ignore-4.0.6.tgz
	https://registry.yarnpkg.com/import-cwd/-/import-cwd-2.1.0.tgz -> yarn-pkg--import-cwd-2.1.0.tgz
	https://registry.yarnpkg.com/import-fresh/-/import-fresh-2.0.0.tgz -> yarn-pkg--import-fresh-2.0.0.tgz
	https://registry.yarnpkg.com/import-fresh/-/import-fresh-3.3.0.tgz -> yarn-pkg--import-fresh-3.3.0.tgz
	https://registry.yarnpkg.com/import-from/-/import-from-2.1.0.tgz -> yarn-pkg--import-from-2.1.0.tgz
	https://registry.yarnpkg.com/import-local/-/import-local-2.0.0.tgz -> yarn-pkg--import-local-2.0.0.tgz
	https://registry.yarnpkg.com/imurmurhash/-/imurmurhash-0.1.4.tgz -> yarn-pkg--imurmurhash-0.1.4.tgz
	https://registry.yarnpkg.com/indent-string/-/indent-string-4.0.0.tgz -> yarn-pkg--indent-string-4.0.0.tgz
	https://registry.yarnpkg.com/indexes-of/-/indexes-of-1.0.1.tgz -> yarn-pkg--indexes-of-1.0.1.tgz
	https://registry.yarnpkg.com/infer-owner/-/infer-owner-1.0.4.tgz -> yarn-pkg--infer-owner-1.0.4.tgz
	https://registry.yarnpkg.com/inflight/-/inflight-1.0.6.tgz -> yarn-pkg--inflight-1.0.6.tgz
	https://registry.yarnpkg.com/inherits/-/inherits-2.0.1.tgz -> yarn-pkg--inherits-2.0.1.tgz
	https://registry.yarnpkg.com/inherits/-/inherits-2.0.3.tgz -> yarn-pkg--inherits-2.0.3.tgz
	https://registry.yarnpkg.com/inherits/-/inherits-2.0.4.tgz -> yarn-pkg--inherits-2.0.4.tgz
	https://registry.yarnpkg.com/inquirer/-/inquirer-6.5.2.tgz -> yarn-pkg--inquirer-6.5.2.tgz
	https://registry.yarnpkg.com/inquirer/-/inquirer-7.3.3.tgz -> yarn-pkg--inquirer-7.3.3.tgz
	https://registry.yarnpkg.com/internal-ip/-/internal-ip-4.3.0.tgz -> yarn-pkg--internal-ip-4.3.0.tgz
	https://registry.yarnpkg.com/@intervolga/optimize-cssnano-plugin/-/optimize-cssnano-plugin-1.0.6.tgz -> yarn-pkg-@intervolga-optimize-cssnano-plugin-1.0.6.tgz
	https://registry.yarnpkg.com/ipaddr.js/-/ipaddr.js-1.9.1.tgz -> yarn-pkg--ipaddr.js-1.9.1.tgz
	https://registry.yarnpkg.com/ip/-/ip-1.1.5.tgz -> yarn-pkg--ip-1.1.5.tgz
	https://registry.yarnpkg.com/ip-regex/-/ip-regex-2.1.0.tgz -> yarn-pkg--ip-regex-2.1.0.tgz
	https://registry.yarnpkg.com/is-absolute-url/-/is-absolute-url-2.1.0.tgz -> yarn-pkg--is-absolute-url-2.1.0.tgz
	https://registry.yarnpkg.com/is-absolute-url/-/is-absolute-url-3.0.3.tgz -> yarn-pkg--is-absolute-url-3.0.3.tgz
	https://registry.yarnpkg.com/is-accessor-descriptor/-/is-accessor-descriptor-0.1.6.tgz -> yarn-pkg--is-accessor-descriptor-0.1.6.tgz
	https://registry.yarnpkg.com/is-accessor-descriptor/-/is-accessor-descriptor-1.0.0.tgz -> yarn-pkg--is-accessor-descriptor-1.0.0.tgz
	https://registry.yarnpkg.com/is-arguments/-/is-arguments-1.1.0.tgz -> yarn-pkg--is-arguments-1.1.0.tgz
	https://registry.yarnpkg.com/isarray/-/isarray-0.0.1.tgz -> yarn-pkg--isarray-0.0.1.tgz
	https://registry.yarnpkg.com/isarray/-/isarray-1.0.0.tgz -> yarn-pkg--isarray-1.0.0.tgz
	https://registry.yarnpkg.com/isarray/-/isarray-2.0.5.tgz -> yarn-pkg--isarray-2.0.5.tgz
	https://registry.yarnpkg.com/is-arrayish/-/is-arrayish-0.2.1.tgz -> yarn-pkg--is-arrayish-0.2.1.tgz
	https://registry.yarnpkg.com/is-arrayish/-/is-arrayish-0.3.2.tgz -> yarn-pkg--is-arrayish-0.3.2.tgz
	https://registry.yarnpkg.com/is-binary-path/-/is-binary-path-1.0.1.tgz -> yarn-pkg--is-binary-path-1.0.1.tgz
	https://registry.yarnpkg.com/is-binary-path/-/is-binary-path-2.1.0.tgz -> yarn-pkg--is-binary-path-2.1.0.tgz
	https://registry.yarnpkg.com/is-buffer/-/is-buffer-1.1.6.tgz -> yarn-pkg--is-buffer-1.1.6.tgz
	https://registry.yarnpkg.com/is-callable/-/is-callable-1.2.2.tgz -> yarn-pkg--is-callable-1.2.2.tgz
	https://registry.yarnpkg.com/is-ci/-/is-ci-1.2.1.tgz -> yarn-pkg--is-ci-1.2.1.tgz
	https://registry.yarnpkg.com/is-color-stop/-/is-color-stop-1.1.0.tgz -> yarn-pkg--is-color-stop-1.1.0.tgz
	https://registry.yarnpkg.com/is-core-module/-/is-core-module-2.2.0.tgz -> yarn-pkg--is-core-module-2.2.0.tgz
	https://registry.yarnpkg.com/is-data-descriptor/-/is-data-descriptor-0.1.4.tgz -> yarn-pkg--is-data-descriptor-0.1.4.tgz
	https://registry.yarnpkg.com/is-data-descriptor/-/is-data-descriptor-1.0.0.tgz -> yarn-pkg--is-data-descriptor-1.0.0.tgz
	https://registry.yarnpkg.com/is-date-object/-/is-date-object-1.0.2.tgz -> yarn-pkg--is-date-object-1.0.2.tgz
	https://registry.yarnpkg.com/is-descriptor/-/is-descriptor-0.1.6.tgz -> yarn-pkg--is-descriptor-0.1.6.tgz
	https://registry.yarnpkg.com/is-descriptor/-/is-descriptor-1.0.2.tgz -> yarn-pkg--is-descriptor-1.0.2.tgz
	https://registry.yarnpkg.com/is-directory/-/is-directory-0.3.1.tgz -> yarn-pkg--is-directory-0.3.1.tgz
	https://registry.yarnpkg.com/is-docker/-/is-docker-2.1.1.tgz -> yarn-pkg--is-docker-2.1.1.tgz
	https://registry.yarnpkg.com/isexe/-/isexe-2.0.0.tgz -> yarn-pkg--isexe-2.0.0.tgz
	https://registry.yarnpkg.com/is-extendable/-/is-extendable-0.1.1.tgz -> yarn-pkg--is-extendable-0.1.1.tgz
	https://registry.yarnpkg.com/is-extendable/-/is-extendable-1.0.1.tgz -> yarn-pkg--is-extendable-1.0.1.tgz
	https://registry.yarnpkg.com/is-extglob/-/is-extglob-2.1.1.tgz -> yarn-pkg--is-extglob-2.1.1.tgz
	https://registry.yarnpkg.com/is-fullwidth-code-point/-/is-fullwidth-code-point-2.0.0.tgz -> yarn-pkg--is-fullwidth-code-point-2.0.0.tgz
	https://registry.yarnpkg.com/is-fullwidth-code-point/-/is-fullwidth-code-point-3.0.0.tgz -> yarn-pkg--is-fullwidth-code-point-3.0.0.tgz
	https://registry.yarnpkg.com/is-glob/-/is-glob-3.1.0.tgz -> yarn-pkg--is-glob-3.1.0.tgz
	https://registry.yarnpkg.com/is-glob/-/is-glob-4.0.1.tgz -> yarn-pkg--is-glob-4.0.1.tgz
	https://registry.yarnpkg.com/is-negative-zero/-/is-negative-zero-2.0.1.tgz -> yarn-pkg--is-negative-zero-2.0.1.tgz
	https://registry.yarnpkg.com/is-number/-/is-number-3.0.0.tgz -> yarn-pkg--is-number-3.0.0.tgz
	https://registry.yarnpkg.com/is-number/-/is-number-7.0.0.tgz -> yarn-pkg--is-number-7.0.0.tgz
	https://registry.yarnpkg.com/isobject/-/isobject-2.1.0.tgz -> yarn-pkg--isobject-2.1.0.tgz
	https://registry.yarnpkg.com/isobject/-/isobject-3.0.1.tgz -> yarn-pkg--isobject-3.0.1.tgz
	https://registry.yarnpkg.com/is-obj/-/is-obj-2.0.0.tgz -> yarn-pkg--is-obj-2.0.0.tgz
	https://registry.yarnpkg.com/is-path-cwd/-/is-path-cwd-2.2.0.tgz -> yarn-pkg--is-path-cwd-2.2.0.tgz
	https://registry.yarnpkg.com/is-path-in-cwd/-/is-path-in-cwd-2.1.0.tgz -> yarn-pkg--is-path-in-cwd-2.1.0.tgz
	https://registry.yarnpkg.com/is-path-inside/-/is-path-inside-2.1.0.tgz -> yarn-pkg--is-path-inside-2.1.0.tgz
	https://registry.yarnpkg.com/is-plain-object/-/is-plain-object-2.0.4.tgz -> yarn-pkg--is-plain-object-2.0.4.tgz
	https://registry.yarnpkg.com/is-plain-obj/-/is-plain-obj-1.1.0.tgz -> yarn-pkg--is-plain-obj-1.1.0.tgz
	https://registry.yarnpkg.com/is-promise/-/is-promise-1.0.1.tgz -> yarn-pkg--is-promise-1.0.1.tgz
	https://registry.yarnpkg.com/is-regex/-/is-regex-1.1.1.tgz -> yarn-pkg--is-regex-1.1.1.tgz
	https://registry.yarnpkg.com/is-resolvable/-/is-resolvable-1.1.0.tgz -> yarn-pkg--is-resolvable-1.1.0.tgz
	https://registry.yarnpkg.com/isstream/-/isstream-0.1.2.tgz -> yarn-pkg--isstream-0.1.2.tgz
	https://registry.yarnpkg.com/is-stream/-/is-stream-1.1.0.tgz -> yarn-pkg--is-stream-1.1.0.tgz
	https://registry.yarnpkg.com/is-stream/-/is-stream-2.0.0.tgz -> yarn-pkg--is-stream-2.0.0.tgz
	https://registry.yarnpkg.com/is-svg/-/is-svg-3.0.0.tgz -> yarn-pkg--is-svg-3.0.0.tgz
	https://registry.yarnpkg.com/is-symbol/-/is-symbol-1.0.3.tgz -> yarn-pkg--is-symbol-1.0.3.tgz
	https://registry.yarnpkg.com/is-typedarray/-/is-typedarray-1.0.0.tgz -> yarn-pkg--is-typedarray-1.0.0.tgz
	https://registry.yarnpkg.com/is-windows/-/is-windows-1.0.2.tgz -> yarn-pkg--is-windows-1.0.2.tgz
	https://registry.yarnpkg.com/is-wsl/-/is-wsl-1.1.0.tgz -> yarn-pkg--is-wsl-1.1.0.tgz
	https://registry.yarnpkg.com/is-wsl/-/is-wsl-2.2.0.tgz -> yarn-pkg--is-wsl-2.2.0.tgz
	https://registry.yarnpkg.com/javascript-stringify/-/javascript-stringify-2.0.1.tgz -> yarn-pkg--javascript-stringify-2.0.1.tgz
	https://registry.yarnpkg.com/jest-worker/-/jest-worker-25.5.0.tgz -> yarn-pkg--jest-worker-25.5.0.tgz
	https://registry.yarnpkg.com/js-base64/-/js-base64-2.6.4.tgz -> yarn-pkg--js-base64-2.6.4.tgz
	https://registry.yarnpkg.com/jsbn/-/jsbn-0.1.1.tgz -> yarn-pkg--jsbn-0.1.1.tgz
	https://registry.yarnpkg.com/jsesc/-/jsesc-0.5.0.tgz -> yarn-pkg--jsesc-0.5.0.tgz
	https://registry.yarnpkg.com/jsesc/-/jsesc-2.5.2.tgz -> yarn-pkg--jsesc-2.5.2.tgz
	https://registry.yarnpkg.com/js-message/-/js-message-1.0.7.tgz -> yarn-pkg--js-message-1.0.7.tgz
	https://registry.yarnpkg.com/json3/-/json3-3.3.3.tgz -> yarn-pkg--json3-3.3.3.tgz
	https://registry.yarnpkg.com/json5/-/json5-0.5.1.tgz -> yarn-pkg--json5-0.5.1.tgz
	https://registry.yarnpkg.com/json5/-/json5-1.0.1.tgz -> yarn-pkg--json5-1.0.1.tgz
	https://registry.yarnpkg.com/json5/-/json5-2.1.3.tgz -> yarn-pkg--json5-2.1.3.tgz
	https://registry.yarnpkg.com/jsonfile/-/jsonfile-4.0.0.tgz -> yarn-pkg--jsonfile-4.0.0.tgz
	https://registry.yarnpkg.com/json-parse-better-errors/-/json-parse-better-errors-1.0.2.tgz -> yarn-pkg--json-parse-better-errors-1.0.2.tgz
	https://registry.yarnpkg.com/json-parse-even-better-errors/-/json-parse-even-better-errors-2.3.1.tgz -> yarn-pkg--json-parse-even-better-errors-2.3.1.tgz
	https://registry.yarnpkg.com/json-schema/-/json-schema-0.2.3.tgz -> yarn-pkg--json-schema-0.2.3.tgz
	https://registry.yarnpkg.com/json-schema-traverse/-/json-schema-traverse-0.4.1.tgz -> yarn-pkg--json-schema-traverse-0.4.1.tgz
	https://registry.yarnpkg.com/json-stable-stringify-without-jsonify/-/json-stable-stringify-without-jsonify-1.0.1.tgz -> yarn-pkg--json-stable-stringify-without-jsonify-1.0.1.tgz
	https://registry.yarnpkg.com/json-stringify-safe/-/json-stringify-safe-5.0.1.tgz -> yarn-pkg--json-stringify-safe-5.0.1.tgz
	https://registry.yarnpkg.com/jsprim/-/jsprim-1.4.1.tgz -> yarn-pkg--jsprim-1.4.1.tgz
	https://registry.yarnpkg.com/js-queue/-/js-queue-2.0.2.tgz -> yarn-pkg--js-queue-2.0.2.tgz
	https://registry.yarnpkg.com/js-tokens/-/js-tokens-4.0.0.tgz -> yarn-pkg--js-tokens-4.0.0.tgz
	https://registry.yarnpkg.com/js-yaml/-/js-yaml-3.14.1.tgz -> yarn-pkg--js-yaml-3.14.1.tgz
	https://registry.yarnpkg.com/killable/-/killable-1.0.1.tgz -> yarn-pkg--killable-1.0.1.tgz
	https://registry.yarnpkg.com/kind-of/-/kind-of-3.2.2.tgz -> yarn-pkg--kind-of-3.2.2.tgz
	https://registry.yarnpkg.com/kind-of/-/kind-of-4.0.0.tgz -> yarn-pkg--kind-of-4.0.0.tgz
	https://registry.yarnpkg.com/kind-of/-/kind-of-5.1.0.tgz -> yarn-pkg--kind-of-5.1.0.tgz
	https://registry.yarnpkg.com/kind-of/-/kind-of-6.0.3.tgz -> yarn-pkg--kind-of-6.0.3.tgz
	https://registry.yarnpkg.com/launch-editor/-/launch-editor-2.2.1.tgz -> yarn-pkg--launch-editor-2.2.1.tgz
	https://registry.yarnpkg.com/launch-editor-middleware/-/launch-editor-middleware-2.2.1.tgz -> yarn-pkg--launch-editor-middleware-2.2.1.tgz
	https://registry.yarnpkg.com/levn/-/levn-0.3.0.tgz -> yarn-pkg--levn-0.3.0.tgz
	https://registry.yarnpkg.com/lines-and-columns/-/lines-and-columns-1.1.6.tgz -> yarn-pkg--lines-and-columns-1.1.6.tgz
	https://registry.yarnpkg.com/loader-fs-cache/-/loader-fs-cache-1.0.3.tgz -> yarn-pkg--loader-fs-cache-1.0.3.tgz
	https://registry.yarnpkg.com/loader-runner/-/loader-runner-2.4.0.tgz -> yarn-pkg--loader-runner-2.4.0.tgz
	https://registry.yarnpkg.com/loader-utils/-/loader-utils-0.2.17.tgz -> yarn-pkg--loader-utils-0.2.17.tgz
	https://registry.yarnpkg.com/loader-utils/-/loader-utils-1.4.0.tgz -> yarn-pkg--loader-utils-1.4.0.tgz
	https://registry.yarnpkg.com/loader-utils/-/loader-utils-2.0.0.tgz -> yarn-pkg--loader-utils-2.0.0.tgz
	https://registry.yarnpkg.com/locate-path/-/locate-path-2.0.0.tgz -> yarn-pkg--locate-path-2.0.0.tgz
	https://registry.yarnpkg.com/locate-path/-/locate-path-3.0.0.tgz -> yarn-pkg--locate-path-3.0.0.tgz
	https://registry.yarnpkg.com/locate-path/-/locate-path-5.0.0.tgz -> yarn-pkg--locate-path-5.0.0.tgz
	https://registry.yarnpkg.com/lodash.defaultsdeep/-/lodash.defaultsdeep-4.6.1.tgz -> yarn-pkg--lodash.defaultsdeep-4.6.1.tgz
	https://registry.yarnpkg.com/lodash.kebabcase/-/lodash.kebabcase-4.1.1.tgz -> yarn-pkg--lodash.kebabcase-4.1.1.tgz
	https://registry.yarnpkg.com/lodash/-/lodash-4.17.21.tgz -> yarn-pkg--lodash-4.17.21.tgz
	https://registry.yarnpkg.com/lodash.mapvalues/-/lodash.mapvalues-4.6.0.tgz -> yarn-pkg--lodash.mapvalues-4.6.0.tgz
	https://registry.yarnpkg.com/lodash.memoize/-/lodash.memoize-4.1.2.tgz -> yarn-pkg--lodash.memoize-4.1.2.tgz
	https://registry.yarnpkg.com/lodash.transform/-/lodash.transform-4.6.0.tgz -> yarn-pkg--lodash.transform-4.6.0.tgz
	https://registry.yarnpkg.com/lodash.uniq/-/lodash.uniq-4.5.0.tgz -> yarn-pkg--lodash.uniq-4.5.0.tgz
	https://registry.yarnpkg.com/loglevel/-/loglevel-1.7.1.tgz -> yarn-pkg--loglevel-1.7.1.tgz
	https://registry.yarnpkg.com/log-symbols/-/log-symbols-2.2.0.tgz -> yarn-pkg--log-symbols-2.2.0.tgz
	https://registry.yarnpkg.com/lower-case/-/lower-case-1.1.4.tgz -> yarn-pkg--lower-case-1.1.4.tgz
	https://registry.yarnpkg.com/lru-cache/-/lru-cache-4.1.5.tgz -> yarn-pkg--lru-cache-4.1.5.tgz
	https://registry.yarnpkg.com/lru-cache/-/lru-cache-5.1.1.tgz -> yarn-pkg--lru-cache-5.1.1.tgz
	https://registry.yarnpkg.com/make-dir/-/make-dir-1.3.0.tgz -> yarn-pkg--make-dir-1.3.0.tgz
	https://registry.yarnpkg.com/make-dir/-/make-dir-2.1.0.tgz -> yarn-pkg--make-dir-2.1.0.tgz
	https://registry.yarnpkg.com/make-dir/-/make-dir-3.1.0.tgz -> yarn-pkg--make-dir-3.1.0.tgz
	https://registry.yarnpkg.com/map-cache/-/map-cache-0.2.2.tgz -> yarn-pkg--map-cache-0.2.2.tgz
	https://registry.yarnpkg.com/map-visit/-/map-visit-1.0.0.tgz -> yarn-pkg--map-visit-1.0.0.tgz
	https://registry.yarnpkg.com/md5.js/-/md5.js-1.3.5.tgz -> yarn-pkg--md5.js-1.3.5.tgz
	https://registry.yarnpkg.com/@mdi/font/-/font-5.8.55.tgz -> yarn-pkg-@mdi-font-5.8.55.tgz
	https://registry.yarnpkg.com/mdn-data/-/mdn-data-2.0.14.tgz -> yarn-pkg--mdn-data-2.0.14.tgz
	https://registry.yarnpkg.com/mdn-data/-/mdn-data-2.0.4.tgz -> yarn-pkg--mdn-data-2.0.4.tgz
	https://registry.yarnpkg.com/media-typer/-/media-typer-0.3.0.tgz -> yarn-pkg--media-typer-0.3.0.tgz
	https://registry.yarnpkg.com/memory-fs/-/memory-fs-0.4.1.tgz -> yarn-pkg--memory-fs-0.4.1.tgz
	https://registry.yarnpkg.com/memory-fs/-/memory-fs-0.5.0.tgz -> yarn-pkg--memory-fs-0.5.0.tgz
	https://registry.yarnpkg.com/merge2/-/merge2-1.4.1.tgz -> yarn-pkg--merge2-1.4.1.tgz
	https://registry.yarnpkg.com/merge-descriptors/-/merge-descriptors-1.0.1.tgz -> yarn-pkg--merge-descriptors-1.0.1.tgz
	https://registry.yarnpkg.com/merge-source-map/-/merge-source-map-1.1.0.tgz -> yarn-pkg--merge-source-map-1.1.0.tgz
	https://registry.yarnpkg.com/merge-stream/-/merge-stream-2.0.0.tgz -> yarn-pkg--merge-stream-2.0.0.tgz
	https://registry.yarnpkg.com/methods/-/methods-1.1.2.tgz -> yarn-pkg--methods-1.1.2.tgz
	https://registry.yarnpkg.com/microbuffer/-/microbuffer-1.0.0.tgz -> yarn-pkg--microbuffer-1.0.0.tgz
	https://registry.yarnpkg.com/micromatch/-/micromatch-3.1.10.tgz -> yarn-pkg--micromatch-3.1.10.tgz
	https://registry.yarnpkg.com/miller-rabin/-/miller-rabin-4.0.1.tgz -> yarn-pkg--miller-rabin-4.0.1.tgz
	https://registry.yarnpkg.com/mime-db/-/mime-db-1.45.0.tgz -> yarn-pkg--mime-db-1.45.0.tgz
	https://registry.yarnpkg.com/mime/-/mime-1.6.0.tgz -> yarn-pkg--mime-1.6.0.tgz
	https://registry.yarnpkg.com/mime/-/mime-2.4.7.tgz -> yarn-pkg--mime-2.4.7.tgz
	https://registry.yarnpkg.com/mime-types/-/mime-types-2.1.28.tgz -> yarn-pkg--mime-types-2.1.28.tgz
	https://registry.yarnpkg.com/mimic-fn/-/mimic-fn-1.2.0.tgz -> yarn-pkg--mimic-fn-1.2.0.tgz
	https://registry.yarnpkg.com/mimic-fn/-/mimic-fn-2.1.0.tgz -> yarn-pkg--mimic-fn-2.1.0.tgz
	https://registry.yarnpkg.com/mini-css-extract-plugin/-/mini-css-extract-plugin-0.9.0.tgz -> yarn-pkg--mini-css-extract-plugin-0.9.0.tgz
	https://registry.yarnpkg.com/minimalistic-assert/-/minimalistic-assert-1.0.1.tgz -> yarn-pkg--minimalistic-assert-1.0.1.tgz
	https://registry.yarnpkg.com/minimalistic-crypto-utils/-/minimalistic-crypto-utils-1.0.1.tgz -> yarn-pkg--minimalistic-crypto-utils-1.0.1.tgz
	https://registry.yarnpkg.com/minimatch/-/minimatch-3.0.4.tgz -> yarn-pkg--minimatch-3.0.4.tgz
	https://registry.yarnpkg.com/minimist/-/minimist-1.2.5.tgz -> yarn-pkg--minimist-1.2.5.tgz
	https://registry.yarnpkg.com/minipass-collect/-/minipass-collect-1.0.2.tgz -> yarn-pkg--minipass-collect-1.0.2.tgz
	https://registry.yarnpkg.com/minipass-flush/-/minipass-flush-1.0.5.tgz -> yarn-pkg--minipass-flush-1.0.5.tgz
	https://registry.yarnpkg.com/minipass/-/minipass-3.1.3.tgz -> yarn-pkg--minipass-3.1.3.tgz
	https://registry.yarnpkg.com/minipass-pipeline/-/minipass-pipeline-1.2.4.tgz -> yarn-pkg--minipass-pipeline-1.2.4.tgz
	https://registry.yarnpkg.com/mississippi/-/mississippi-2.0.0.tgz -> yarn-pkg--mississippi-2.0.0.tgz
	https://registry.yarnpkg.com/mississippi/-/mississippi-3.0.0.tgz -> yarn-pkg--mississippi-3.0.0.tgz
	https://registry.yarnpkg.com/mixin-deep/-/mixin-deep-1.3.2.tgz -> yarn-pkg--mixin-deep-1.3.2.tgz
	https://registry.yarnpkg.com/mkdirp/-/mkdirp-0.5.5.tgz -> yarn-pkg--mkdirp-0.5.5.tgz
	https://registry.yarnpkg.com/move-concurrently/-/move-concurrently-1.0.1.tgz -> yarn-pkg--move-concurrently-1.0.1.tgz
	https://registry.yarnpkg.com/@mrmlnc/readdir-enhanced/-/readdir-enhanced-2.2.1.tgz -> yarn-pkg-@mrmlnc-readdir-enhanced-2.2.1.tgz
	https://registry.yarnpkg.com/ms/-/ms-2.0.0.tgz -> yarn-pkg--ms-2.0.0.tgz
	https://registry.yarnpkg.com/ms/-/ms-2.1.1.tgz -> yarn-pkg--ms-2.1.1.tgz
	https://registry.yarnpkg.com/ms/-/ms-2.1.2.tgz -> yarn-pkg--ms-2.1.2.tgz
	https://registry.yarnpkg.com/ms/-/ms-2.1.3.tgz -> yarn-pkg--ms-2.1.3.tgz
	https://registry.yarnpkg.com/multicast-dns/-/multicast-dns-6.2.3.tgz -> yarn-pkg--multicast-dns-6.2.3.tgz
	https://registry.yarnpkg.com/multicast-dns-service-types/-/multicast-dns-service-types-1.1.0.tgz -> yarn-pkg--multicast-dns-service-types-1.1.0.tgz
	https://registry.yarnpkg.com/mute-stream/-/mute-stream-0.0.7.tgz -> yarn-pkg--mute-stream-0.0.7.tgz
	https://registry.yarnpkg.com/mute-stream/-/mute-stream-0.0.8.tgz -> yarn-pkg--mute-stream-0.0.8.tgz
	https://registry.yarnpkg.com/mz/-/mz-2.7.0.tgz -> yarn-pkg--mz-2.7.0.tgz
	https://registry.yarnpkg.com/nan/-/nan-2.14.2.tgz -> yarn-pkg--nan-2.14.2.tgz
	https://registry.yarnpkg.com/nanomatch/-/nanomatch-1.2.13.tgz -> yarn-pkg--nanomatch-1.2.13.tgz
	https://registry.yarnpkg.com/natural-compare/-/natural-compare-1.4.0.tgz -> yarn-pkg--natural-compare-1.4.0.tgz
	https://registry.yarnpkg.com/neatequal/-/neatequal-1.0.0.tgz -> yarn-pkg--neatequal-1.0.0.tgz
	https://registry.yarnpkg.com/negotiator/-/negotiator-0.6.2.tgz -> yarn-pkg--negotiator-0.6.2.tgz
	https://registry.yarnpkg.com/neo-async/-/neo-async-2.6.2.tgz -> yarn-pkg--neo-async-2.6.2.tgz
	https://registry.yarnpkg.com/nice-try/-/nice-try-1.0.5.tgz -> yarn-pkg--nice-try-1.0.5.tgz
	https://registry.yarnpkg.com/no-case/-/no-case-2.3.2.tgz -> yarn-pkg--no-case-2.3.2.tgz
	https://registry.yarnpkg.com/node-forge/-/node-forge-0.10.0.tgz -> yarn-pkg--node-forge-0.10.0.tgz
	https://registry.yarnpkg.com/nodeify/-/nodeify-1.0.1.tgz -> yarn-pkg--nodeify-1.0.1.tgz
	https://registry.yarnpkg.com/node-ipc/-/node-ipc-9.1.3.tgz -> yarn-pkg--node-ipc-9.1.3.tgz
	https://registry.yarnpkg.com/@nodelib/fs.stat/-/fs.stat-1.1.3.tgz -> yarn-pkg-@nodelib-fs.stat-1.1.3.tgz
	https://registry.yarnpkg.com/node-libs-browser/-/node-libs-browser-2.2.1.tgz -> yarn-pkg--node-libs-browser-2.2.1.tgz
	https://registry.yarnpkg.com/node-releases/-/node-releases-1.1.72.tgz -> yarn-pkg--node-releases-1.1.72.tgz
	https://registry.yarnpkg.com/normalize.css/-/normalize.css-8.0.1.tgz -> yarn-pkg--normalize.css-8.0.1.tgz
	https://registry.yarnpkg.com/normalize-package-data/-/normalize-package-data-2.5.0.tgz -> yarn-pkg--normalize-package-data-2.5.0.tgz
	https://registry.yarnpkg.com/normalize-path/-/normalize-path-1.0.0.tgz -> yarn-pkg--normalize-path-1.0.0.tgz
	https://registry.yarnpkg.com/normalize-path/-/normalize-path-2.1.1.tgz -> yarn-pkg--normalize-path-2.1.1.tgz
	https://registry.yarnpkg.com/normalize-path/-/normalize-path-3.0.0.tgz -> yarn-pkg--normalize-path-3.0.0.tgz
	https://registry.yarnpkg.com/normalize-range/-/normalize-range-0.1.2.tgz -> yarn-pkg--normalize-range-0.1.2.tgz
	https://registry.yarnpkg.com/normalize-url/-/normalize-url-1.9.1.tgz -> yarn-pkg--normalize-url-1.9.1.tgz
	https://registry.yarnpkg.com/normalize-url/-/normalize-url-3.3.0.tgz -> yarn-pkg--normalize-url-3.3.0.tgz
	https://registry.yarnpkg.com/npm-run-path/-/npm-run-path-2.0.2.tgz -> yarn-pkg--npm-run-path-2.0.2.tgz
	https://registry.yarnpkg.com/npm-run-path/-/npm-run-path-4.0.1.tgz -> yarn-pkg--npm-run-path-4.0.1.tgz
	https://registry.yarnpkg.com/nth-check/-/nth-check-1.0.2.tgz -> yarn-pkg--nth-check-1.0.2.tgz
	https://registry.yarnpkg.com/num2fraction/-/num2fraction-1.2.2.tgz -> yarn-pkg--num2fraction-1.2.2.tgz
	https://registry.yarnpkg.com/nunjucks/-/nunjucks-3.2.2.tgz -> yarn-pkg--nunjucks-3.2.2.tgz
	https://registry.yarnpkg.com/oauth-sign/-/oauth-sign-0.9.0.tgz -> yarn-pkg--oauth-sign-0.9.0.tgz
	https://registry.yarnpkg.com/object-assign/-/object-assign-4.1.1.tgz -> yarn-pkg--object-assign-4.1.1.tgz
	https://registry.yarnpkg.com/object.assign/-/object.assign-4.1.2.tgz -> yarn-pkg--object.assign-4.1.2.tgz
	https://registry.yarnpkg.com/object-copy/-/object-copy-0.1.0.tgz -> yarn-pkg--object-copy-0.1.0.tgz
	https://registry.yarnpkg.com/object.getownpropertydescriptors/-/object.getownpropertydescriptors-2.1.1.tgz -> yarn-pkg--object.getownpropertydescriptors-2.1.1.tgz
	https://registry.yarnpkg.com/object-hash/-/object-hash-1.3.1.tgz -> yarn-pkg--object-hash-1.3.1.tgz
	https://registry.yarnpkg.com/object-inspect/-/object-inspect-1.9.0.tgz -> yarn-pkg--object-inspect-1.9.0.tgz
	https://registry.yarnpkg.com/object-is/-/object-is-1.1.4.tgz -> yarn-pkg--object-is-1.1.4.tgz
	https://registry.yarnpkg.com/object-keys/-/object-keys-1.1.1.tgz -> yarn-pkg--object-keys-1.1.1.tgz
	https://registry.yarnpkg.com/object.pick/-/object.pick-1.3.0.tgz -> yarn-pkg--object.pick-1.3.0.tgz
	https://registry.yarnpkg.com/object.values/-/object.values-1.1.2.tgz -> yarn-pkg--object.values-1.1.2.tgz
	https://registry.yarnpkg.com/object-visit/-/object-visit-1.0.1.tgz -> yarn-pkg--object-visit-1.0.1.tgz
	https://registry.yarnpkg.com/obuf/-/obuf-1.1.2.tgz -> yarn-pkg--obuf-1.1.2.tgz
	https://registry.yarnpkg.com/once/-/once-1.4.0.tgz -> yarn-pkg--once-1.4.0.tgz
	https://registry.yarnpkg.com/onetime/-/onetime-2.0.1.tgz -> yarn-pkg--onetime-2.0.1.tgz
	https://registry.yarnpkg.com/onetime/-/onetime-5.1.2.tgz -> yarn-pkg--onetime-5.1.2.tgz
	https://registry.yarnpkg.com/on-finished/-/on-finished-2.3.0.tgz -> yarn-pkg--on-finished-2.3.0.tgz
	https://registry.yarnpkg.com/on-headers/-/on-headers-1.0.2.tgz -> yarn-pkg--on-headers-1.0.2.tgz
	https://registry.yarnpkg.com/opener/-/opener-1.5.2.tgz -> yarn-pkg--opener-1.5.2.tgz
	https://registry.yarnpkg.com/open/-/open-6.4.0.tgz -> yarn-pkg--open-6.4.0.tgz
	https://registry.yarnpkg.com/opn/-/opn-5.5.0.tgz -> yarn-pkg--opn-5.5.0.tgz
	https://registry.yarnpkg.com/optionator/-/optionator-0.8.3.tgz -> yarn-pkg--optionator-0.8.3.tgz
	https://registry.yarnpkg.com/ora/-/ora-3.4.0.tgz -> yarn-pkg--ora-3.4.0.tgz
	https://registry.yarnpkg.com/original/-/original-1.0.2.tgz -> yarn-pkg--original-1.0.2.tgz
	https://registry.yarnpkg.com/os-browserify/-/os-browserify-0.3.0.tgz -> yarn-pkg--os-browserify-0.3.0.tgz
	https://registry.yarnpkg.com/os-tmpdir/-/os-tmpdir-1.0.2.tgz -> yarn-pkg--os-tmpdir-1.0.2.tgz
	https://registry.yarnpkg.com/pako/-/pako-1.0.11.tgz -> yarn-pkg--pako-1.0.11.tgz
	https://registry.yarnpkg.com/parallel-transform/-/parallel-transform-1.2.0.tgz -> yarn-pkg--parallel-transform-1.2.0.tgz
	https://registry.yarnpkg.com/param-case/-/param-case-2.1.1.tgz -> yarn-pkg--param-case-2.1.1.tgz
	https://registry.yarnpkg.com/parent-module/-/parent-module-1.0.1.tgz -> yarn-pkg--parent-module-1.0.1.tgz
	https://registry.yarnpkg.com/parse5-htmlparser2-tree-adapter/-/parse5-htmlparser2-tree-adapter-6.0.1.tgz -> yarn-pkg--parse5-htmlparser2-tree-adapter-6.0.1.tgz
	https://registry.yarnpkg.com/parse5/-/parse5-5.1.1.tgz -> yarn-pkg--parse5-5.1.1.tgz
	https://registry.yarnpkg.com/parse5/-/parse5-6.0.1.tgz -> yarn-pkg--parse5-6.0.1.tgz
	https://registry.yarnpkg.com/parse-asn1/-/parse-asn1-5.1.6.tgz -> yarn-pkg--parse-asn1-5.1.6.tgz
	https://registry.yarnpkg.com/parse-json/-/parse-json-4.0.0.tgz -> yarn-pkg--parse-json-4.0.0.tgz
	https://registry.yarnpkg.com/parse-json/-/parse-json-5.1.0.tgz -> yarn-pkg--parse-json-5.1.0.tgz
	https://registry.yarnpkg.com/parseurl/-/parseurl-1.3.3.tgz -> yarn-pkg--parseurl-1.3.3.tgz
	https://registry.yarnpkg.com/pascalcase/-/pascalcase-0.1.1.tgz -> yarn-pkg--pascalcase-0.1.1.tgz
	https://registry.yarnpkg.com/path-browserify/-/path-browserify-0.0.1.tgz -> yarn-pkg--path-browserify-0.0.1.tgz
	https://registry.yarnpkg.com/path-dirname/-/path-dirname-1.0.2.tgz -> yarn-pkg--path-dirname-1.0.2.tgz
	https://registry.yarnpkg.com/path-exists/-/path-exists-2.1.0.tgz -> yarn-pkg--path-exists-2.1.0.tgz
	https://registry.yarnpkg.com/path-exists/-/path-exists-3.0.0.tgz -> yarn-pkg--path-exists-3.0.0.tgz
	https://registry.yarnpkg.com/path-exists/-/path-exists-4.0.0.tgz -> yarn-pkg--path-exists-4.0.0.tgz
	https://registry.yarnpkg.com/path-is-absolute/-/path-is-absolute-1.0.1.tgz -> yarn-pkg--path-is-absolute-1.0.1.tgz
	https://registry.yarnpkg.com/path-is-inside/-/path-is-inside-1.0.2.tgz -> yarn-pkg--path-is-inside-1.0.2.tgz
	https://registry.yarnpkg.com/path-key/-/path-key-2.0.1.tgz -> yarn-pkg--path-key-2.0.1.tgz
	https://registry.yarnpkg.com/path-key/-/path-key-3.1.1.tgz -> yarn-pkg--path-key-3.1.1.tgz
	https://registry.yarnpkg.com/path-parse/-/path-parse-1.0.6.tgz -> yarn-pkg--path-parse-1.0.6.tgz
	https://registry.yarnpkg.com/path-to-regexp/-/path-to-regexp-0.1.7.tgz -> yarn-pkg--path-to-regexp-0.1.7.tgz
	https://registry.yarnpkg.com/path-type/-/path-type-3.0.0.tgz -> yarn-pkg--path-type-3.0.0.tgz
	https://registry.yarnpkg.com/pbkdf2/-/pbkdf2-3.1.1.tgz -> yarn-pkg--pbkdf2-3.1.1.tgz
	https://registry.yarnpkg.com/performance-now/-/performance-now-2.1.0.tgz -> yarn-pkg--performance-now-2.1.0.tgz
	https://registry.yarnpkg.com/p-finally/-/p-finally-1.0.0.tgz -> yarn-pkg--p-finally-1.0.0.tgz
	https://registry.yarnpkg.com/p-finally/-/p-finally-2.0.1.tgz -> yarn-pkg--p-finally-2.0.1.tgz
	https://registry.yarnpkg.com/picomatch/-/picomatch-2.2.2.tgz -> yarn-pkg--picomatch-2.2.2.tgz
	https://registry.yarnpkg.com/pify/-/pify-2.3.0.tgz -> yarn-pkg--pify-2.3.0.tgz
	https://registry.yarnpkg.com/pify/-/pify-3.0.0.tgz -> yarn-pkg--pify-3.0.0.tgz
	https://registry.yarnpkg.com/pify/-/pify-4.0.1.tgz -> yarn-pkg--pify-4.0.1.tgz
	https://registry.yarnpkg.com/pinkie/-/pinkie-2.0.4.tgz -> yarn-pkg--pinkie-2.0.4.tgz
	https://registry.yarnpkg.com/pinkie-promise/-/pinkie-promise-2.0.1.tgz -> yarn-pkg--pinkie-promise-2.0.1.tgz
	https://registry.yarnpkg.com/pkg-dir/-/pkg-dir-1.0.0.tgz -> yarn-pkg--pkg-dir-1.0.0.tgz
	https://registry.yarnpkg.com/pkg-dir/-/pkg-dir-2.0.0.tgz -> yarn-pkg--pkg-dir-2.0.0.tgz
	https://registry.yarnpkg.com/pkg-dir/-/pkg-dir-3.0.0.tgz -> yarn-pkg--pkg-dir-3.0.0.tgz
	https://registry.yarnpkg.com/pkg-dir/-/pkg-dir-4.2.0.tgz -> yarn-pkg--pkg-dir-4.2.0.tgz
	https://registry.yarnpkg.com/p-limit/-/p-limit-1.3.0.tgz -> yarn-pkg--p-limit-1.3.0.tgz
	https://registry.yarnpkg.com/p-limit/-/p-limit-2.3.0.tgz -> yarn-pkg--p-limit-2.3.0.tgz
	https://registry.yarnpkg.com/p-locate/-/p-locate-2.0.0.tgz -> yarn-pkg--p-locate-2.0.0.tgz
	https://registry.yarnpkg.com/p-locate/-/p-locate-3.0.0.tgz -> yarn-pkg--p-locate-3.0.0.tgz
	https://registry.yarnpkg.com/p-locate/-/p-locate-4.1.0.tgz -> yarn-pkg--p-locate-4.1.0.tgz
	https://registry.yarnpkg.com/p-map/-/p-map-2.1.0.tgz -> yarn-pkg--p-map-2.1.0.tgz
	https://registry.yarnpkg.com/p-map/-/p-map-3.0.0.tgz -> yarn-pkg--p-map-3.0.0.tgz
	https://registry.yarnpkg.com/pngjs/-/pngjs-3.4.0.tgz -> yarn-pkg--pngjs-3.4.0.tgz
	https://registry.yarnpkg.com/pnp-webpack-plugin/-/pnp-webpack-plugin-1.6.4.tgz -> yarn-pkg--pnp-webpack-plugin-1.6.4.tgz
	https://registry.yarnpkg.com/portfinder/-/portfinder-1.0.28.tgz -> yarn-pkg--portfinder-1.0.28.tgz
	https://registry.yarnpkg.com/posix-character-classes/-/posix-character-classes-0.1.1.tgz -> yarn-pkg--posix-character-classes-0.1.1.tgz
	https://registry.yarnpkg.com/postcss-calc/-/postcss-calc-7.0.5.tgz -> yarn-pkg--postcss-calc-7.0.5.tgz
	https://registry.yarnpkg.com/postcss-colormin/-/postcss-colormin-4.0.3.tgz -> yarn-pkg--postcss-colormin-4.0.3.tgz
	https://registry.yarnpkg.com/postcss-convert-values/-/postcss-convert-values-4.0.1.tgz -> yarn-pkg--postcss-convert-values-4.0.1.tgz
	https://registry.yarnpkg.com/postcss-discard-comments/-/postcss-discard-comments-4.0.2.tgz -> yarn-pkg--postcss-discard-comments-4.0.2.tgz
	https://registry.yarnpkg.com/postcss-discard-duplicates/-/postcss-discard-duplicates-4.0.2.tgz -> yarn-pkg--postcss-discard-duplicates-4.0.2.tgz
	https://registry.yarnpkg.com/postcss-discard-empty/-/postcss-discard-empty-4.0.1.tgz -> yarn-pkg--postcss-discard-empty-4.0.1.tgz
	https://registry.yarnpkg.com/postcss-discard-overridden/-/postcss-discard-overridden-4.0.1.tgz -> yarn-pkg--postcss-discard-overridden-4.0.1.tgz
	https://registry.yarnpkg.com/postcss-load-config/-/postcss-load-config-2.1.2.tgz -> yarn-pkg--postcss-load-config-2.1.2.tgz
	https://registry.yarnpkg.com/postcss-loader/-/postcss-loader-3.0.0.tgz -> yarn-pkg--postcss-loader-3.0.0.tgz
	https://registry.yarnpkg.com/postcss-merge-longhand/-/postcss-merge-longhand-4.0.11.tgz -> yarn-pkg--postcss-merge-longhand-4.0.11.tgz
	https://registry.yarnpkg.com/postcss-merge-rules/-/postcss-merge-rules-4.0.3.tgz -> yarn-pkg--postcss-merge-rules-4.0.3.tgz
	https://registry.yarnpkg.com/postcss-minify-font-values/-/postcss-minify-font-values-4.0.2.tgz -> yarn-pkg--postcss-minify-font-values-4.0.2.tgz
	https://registry.yarnpkg.com/postcss-minify-gradients/-/postcss-minify-gradients-4.0.2.tgz -> yarn-pkg--postcss-minify-gradients-4.0.2.tgz
	https://registry.yarnpkg.com/postcss-minify-params/-/postcss-minify-params-4.0.2.tgz -> yarn-pkg--postcss-minify-params-4.0.2.tgz
	https://registry.yarnpkg.com/postcss-minify-selectors/-/postcss-minify-selectors-4.0.2.tgz -> yarn-pkg--postcss-minify-selectors-4.0.2.tgz
	https://registry.yarnpkg.com/postcss-modules-extract-imports/-/postcss-modules-extract-imports-2.0.0.tgz -> yarn-pkg--postcss-modules-extract-imports-2.0.0.tgz
	https://registry.yarnpkg.com/postcss-modules-local-by-default/-/postcss-modules-local-by-default-3.0.3.tgz -> yarn-pkg--postcss-modules-local-by-default-3.0.3.tgz
	https://registry.yarnpkg.com/postcss-modules-scope/-/postcss-modules-scope-2.2.0.tgz -> yarn-pkg--postcss-modules-scope-2.2.0.tgz
	https://registry.yarnpkg.com/postcss-modules-values/-/postcss-modules-values-3.0.0.tgz -> yarn-pkg--postcss-modules-values-3.0.0.tgz
	https://registry.yarnpkg.com/postcss-normalize-charset/-/postcss-normalize-charset-4.0.1.tgz -> yarn-pkg--postcss-normalize-charset-4.0.1.tgz
	https://registry.yarnpkg.com/postcss-normalize-display-values/-/postcss-normalize-display-values-4.0.2.tgz -> yarn-pkg--postcss-normalize-display-values-4.0.2.tgz
	https://registry.yarnpkg.com/postcss-normalize-positions/-/postcss-normalize-positions-4.0.2.tgz -> yarn-pkg--postcss-normalize-positions-4.0.2.tgz
	https://registry.yarnpkg.com/postcss-normalize-repeat-style/-/postcss-normalize-repeat-style-4.0.2.tgz -> yarn-pkg--postcss-normalize-repeat-style-4.0.2.tgz
	https://registry.yarnpkg.com/postcss-normalize-string/-/postcss-normalize-string-4.0.2.tgz -> yarn-pkg--postcss-normalize-string-4.0.2.tgz
	https://registry.yarnpkg.com/postcss-normalize-timing-functions/-/postcss-normalize-timing-functions-4.0.2.tgz -> yarn-pkg--postcss-normalize-timing-functions-4.0.2.tgz
	https://registry.yarnpkg.com/postcss-normalize-unicode/-/postcss-normalize-unicode-4.0.1.tgz -> yarn-pkg--postcss-normalize-unicode-4.0.1.tgz
	https://registry.yarnpkg.com/postcss-normalize-url/-/postcss-normalize-url-4.0.1.tgz -> yarn-pkg--postcss-normalize-url-4.0.1.tgz
	https://registry.yarnpkg.com/postcss-normalize-whitespace/-/postcss-normalize-whitespace-4.0.2.tgz -> yarn-pkg--postcss-normalize-whitespace-4.0.2.tgz
	https://registry.yarnpkg.com/postcss-ordered-values/-/postcss-ordered-values-4.1.2.tgz -> yarn-pkg--postcss-ordered-values-4.1.2.tgz
	https://registry.yarnpkg.com/postcss/-/postcss-7.0.36.tgz -> yarn-pkg--postcss-7.0.36.tgz
	https://registry.yarnpkg.com/postcss-reduce-initial/-/postcss-reduce-initial-4.0.3.tgz -> yarn-pkg--postcss-reduce-initial-4.0.3.tgz
	https://registry.yarnpkg.com/postcss-reduce-transforms/-/postcss-reduce-transforms-4.0.2.tgz -> yarn-pkg--postcss-reduce-transforms-4.0.2.tgz
	https://registry.yarnpkg.com/postcss-selector-parser/-/postcss-selector-parser-3.1.2.tgz -> yarn-pkg--postcss-selector-parser-3.1.2.tgz
	https://registry.yarnpkg.com/postcss-selector-parser/-/postcss-selector-parser-6.0.4.tgz -> yarn-pkg--postcss-selector-parser-6.0.4.tgz
	https://registry.yarnpkg.com/postcss-svgo/-/postcss-svgo-4.0.2.tgz -> yarn-pkg--postcss-svgo-4.0.2.tgz
	https://registry.yarnpkg.com/postcss-unique-selectors/-/postcss-unique-selectors-4.0.1.tgz -> yarn-pkg--postcss-unique-selectors-4.0.1.tgz
	https://registry.yarnpkg.com/postcss-value-parser/-/postcss-value-parser-3.3.1.tgz -> yarn-pkg--postcss-value-parser-3.3.1.tgz
	https://registry.yarnpkg.com/postcss-value-parser/-/postcss-value-parser-4.1.0.tgz -> yarn-pkg--postcss-value-parser-4.1.0.tgz
	https://registry.yarnpkg.com/prelude-ls/-/prelude-ls-1.1.2.tgz -> yarn-pkg--prelude-ls-1.1.2.tgz
	https://registry.yarnpkg.com/prepend-http/-/prepend-http-1.0.4.tgz -> yarn-pkg--prepend-http-1.0.4.tgz
	https://registry.yarnpkg.com/p-retry/-/p-retry-3.0.1.tgz -> yarn-pkg--p-retry-3.0.1.tgz
	https://registry.yarnpkg.com/prettier-linter-helpers/-/prettier-linter-helpers-1.0.0.tgz -> yarn-pkg--prettier-linter-helpers-1.0.0.tgz
	https://registry.yarnpkg.com/prettier/-/prettier-1.19.1.tgz -> yarn-pkg--prettier-1.19.1.tgz
	https://registry.yarnpkg.com/pretty-error/-/pretty-error-2.1.2.tgz -> yarn-pkg--pretty-error-2.1.2.tgz
	https://registry.yarnpkg.com/process-nextick-args/-/process-nextick-args-2.0.1.tgz -> yarn-pkg--process-nextick-args-2.0.1.tgz
	https://registry.yarnpkg.com/process/-/process-0.11.10.tgz -> yarn-pkg--process-0.11.10.tgz
	https://registry.yarnpkg.com/progress/-/progress-2.0.3.tgz -> yarn-pkg--progress-2.0.3.tgz
	https://registry.yarnpkg.com/promise-inflight/-/promise-inflight-1.0.1.tgz -> yarn-pkg--promise-inflight-1.0.1.tgz
	https://registry.yarnpkg.com/promise/-/promise-1.3.0.tgz -> yarn-pkg--promise-1.3.0.tgz
	https://registry.yarnpkg.com/proxy-addr/-/proxy-addr-2.0.6.tgz -> yarn-pkg--proxy-addr-2.0.6.tgz
	https://registry.yarnpkg.com/prr/-/prr-1.0.1.tgz -> yarn-pkg--prr-1.0.1.tgz
	https://registry.yarnpkg.com/pseudomap/-/pseudomap-1.0.2.tgz -> yarn-pkg--pseudomap-1.0.2.tgz
	https://registry.yarnpkg.com/psl/-/psl-1.8.0.tgz -> yarn-pkg--psl-1.8.0.tgz
	https://registry.yarnpkg.com/p-try/-/p-try-1.0.0.tgz -> yarn-pkg--p-try-1.0.0.tgz
	https://registry.yarnpkg.com/p-try/-/p-try-2.2.0.tgz -> yarn-pkg--p-try-2.2.0.tgz
	https://registry.yarnpkg.com/public-encrypt/-/public-encrypt-4.0.3.tgz -> yarn-pkg--public-encrypt-4.0.3.tgz
	https://registry.yarnpkg.com/pumpify/-/pumpify-1.5.1.tgz -> yarn-pkg--pumpify-1.5.1.tgz
	https://registry.yarnpkg.com/pump/-/pump-2.0.1.tgz -> yarn-pkg--pump-2.0.1.tgz
	https://registry.yarnpkg.com/pump/-/pump-3.0.0.tgz -> yarn-pkg--pump-3.0.0.tgz
	https://registry.yarnpkg.com/punycode/-/punycode-1.3.2.tgz -> yarn-pkg--punycode-1.3.2.tgz
	https://registry.yarnpkg.com/punycode/-/punycode-1.4.1.tgz -> yarn-pkg--punycode-1.4.1.tgz
	https://registry.yarnpkg.com/punycode/-/punycode-2.1.1.tgz -> yarn-pkg--punycode-2.1.1.tgz
	https://registry.yarnpkg.com/q/-/q-1.5.1.tgz -> yarn-pkg--q-1.5.1.tgz
	https://registry.yarnpkg.com/qrcode/-/qrcode-1.4.4.tgz -> yarn-pkg--qrcode-1.4.4.tgz
	https://registry.yarnpkg.com/qs/-/qs-6.5.2.tgz -> yarn-pkg--qs-6.5.2.tgz
	https://registry.yarnpkg.com/qs/-/qs-6.7.0.tgz -> yarn-pkg--qs-6.7.0.tgz
	https://registry.yarnpkg.com/querystring-es3/-/querystring-es3-0.2.1.tgz -> yarn-pkg--querystring-es3-0.2.1.tgz
	https://registry.yarnpkg.com/querystringify/-/querystringify-2.2.0.tgz -> yarn-pkg--querystringify-2.2.0.tgz
	https://registry.yarnpkg.com/querystring/-/querystring-0.2.0.tgz -> yarn-pkg--querystring-0.2.0.tgz
	https://registry.yarnpkg.com/query-string/-/query-string-4.3.4.tgz -> yarn-pkg--query-string-4.3.4.tgz
	https://registry.yarnpkg.com/randombytes/-/randombytes-2.1.0.tgz -> yarn-pkg--randombytes-2.1.0.tgz
	https://registry.yarnpkg.com/randomfill/-/randomfill-1.0.4.tgz -> yarn-pkg--randomfill-1.0.4.tgz
	https://registry.yarnpkg.com/range-parser/-/range-parser-1.2.1.tgz -> yarn-pkg--range-parser-1.2.1.tgz
	https://registry.yarnpkg.com/raw-body/-/raw-body-2.4.0.tgz -> yarn-pkg--raw-body-2.4.0.tgz
	https://registry.yarnpkg.com/readable-stream/-/readable-stream-1.1.14.tgz -> yarn-pkg--readable-stream-1.1.14.tgz
	https://registry.yarnpkg.com/readable-stream/-/readable-stream-2.3.7.tgz -> yarn-pkg--readable-stream-2.3.7.tgz
	https://registry.yarnpkg.com/readable-stream/-/readable-stream-3.6.0.tgz -> yarn-pkg--readable-stream-3.6.0.tgz
	https://registry.yarnpkg.com/readdirp/-/readdirp-2.2.1.tgz -> yarn-pkg--readdirp-2.2.1.tgz
	https://registry.yarnpkg.com/readdirp/-/readdirp-3.5.0.tgz -> yarn-pkg--readdirp-3.5.0.tgz
	https://registry.yarnpkg.com/read-pkg/-/read-pkg-5.2.0.tgz -> yarn-pkg--read-pkg-5.2.0.tgz
	https://registry.yarnpkg.com/regenerate/-/regenerate-1.4.2.tgz -> yarn-pkg--regenerate-1.4.2.tgz
	https://registry.yarnpkg.com/regenerate-unicode-properties/-/regenerate-unicode-properties-8.2.0.tgz -> yarn-pkg--regenerate-unicode-properties-8.2.0.tgz
	https://registry.yarnpkg.com/regenerator-runtime/-/regenerator-runtime-0.13.7.tgz -> yarn-pkg--regenerator-runtime-0.13.7.tgz
	https://registry.yarnpkg.com/regenerator-transform/-/regenerator-transform-0.14.5.tgz -> yarn-pkg--regenerator-transform-0.14.5.tgz
	https://registry.yarnpkg.com/regex-not/-/regex-not-1.0.2.tgz -> yarn-pkg--regex-not-1.0.2.tgz
	https://registry.yarnpkg.com/regexpp/-/regexpp-2.0.1.tgz -> yarn-pkg--regexpp-2.0.1.tgz
	https://registry.yarnpkg.com/regexp.prototype.flags/-/regexp.prototype.flags-1.3.0.tgz -> yarn-pkg--regexp.prototype.flags-1.3.0.tgz
	https://registry.yarnpkg.com/regexpu-core/-/regexpu-core-4.7.1.tgz -> yarn-pkg--regexpu-core-4.7.1.tgz
	https://registry.yarnpkg.com/register-service-worker/-/register-service-worker-1.7.2.tgz -> yarn-pkg--register-service-worker-1.7.2.tgz
	https://registry.yarnpkg.com/regjsgen/-/regjsgen-0.5.2.tgz -> yarn-pkg--regjsgen-0.5.2.tgz
	https://registry.yarnpkg.com/regjsparser/-/regjsparser-0.6.4.tgz -> yarn-pkg--regjsparser-0.6.4.tgz
	https://registry.yarnpkg.com/relateurl/-/relateurl-0.2.7.tgz -> yarn-pkg--relateurl-0.2.7.tgz
	https://registry.yarnpkg.com/remove-trailing-separator/-/remove-trailing-separator-1.1.0.tgz -> yarn-pkg--remove-trailing-separator-1.1.0.tgz
	https://registry.yarnpkg.com/renderkid/-/renderkid-2.0.5.tgz -> yarn-pkg--renderkid-2.0.5.tgz
	https://registry.yarnpkg.com/repeat-element/-/repeat-element-1.1.3.tgz -> yarn-pkg--repeat-element-1.1.3.tgz
	https://registry.yarnpkg.com/repeat-string/-/repeat-string-1.6.1.tgz -> yarn-pkg--repeat-string-1.6.1.tgz
	https://registry.yarnpkg.com/request/-/request-2.88.2.tgz -> yarn-pkg--request-2.88.2.tgz
	https://registry.yarnpkg.com/require-directory/-/require-directory-2.1.1.tgz -> yarn-pkg--require-directory-2.1.1.tgz
	https://registry.yarnpkg.com/require-main-filename/-/require-main-filename-2.0.0.tgz -> yarn-pkg--require-main-filename-2.0.0.tgz
	https://registry.yarnpkg.com/requires-port/-/requires-port-1.0.0.tgz -> yarn-pkg--requires-port-1.0.0.tgz
	https://registry.yarnpkg.com/resolve-cwd/-/resolve-cwd-2.0.0.tgz -> yarn-pkg--resolve-cwd-2.0.0.tgz
	https://registry.yarnpkg.com/resolve-from/-/resolve-from-3.0.0.tgz -> yarn-pkg--resolve-from-3.0.0.tgz
	https://registry.yarnpkg.com/resolve-from/-/resolve-from-4.0.0.tgz -> yarn-pkg--resolve-from-4.0.0.tgz
	https://registry.yarnpkg.com/resolve/-/resolve-1.19.0.tgz -> yarn-pkg--resolve-1.19.0.tgz
	https://registry.yarnpkg.com/resolve-url/-/resolve-url-0.2.1.tgz -> yarn-pkg--resolve-url-0.2.1.tgz
	https://registry.yarnpkg.com/restore-cursor/-/restore-cursor-2.0.0.tgz -> yarn-pkg--restore-cursor-2.0.0.tgz
	https://registry.yarnpkg.com/restore-cursor/-/restore-cursor-3.1.0.tgz -> yarn-pkg--restore-cursor-3.1.0.tgz
	https://registry.yarnpkg.com/ret/-/ret-0.1.15.tgz -> yarn-pkg--ret-0.1.15.tgz
	https://registry.yarnpkg.com/retry/-/retry-0.12.0.tgz -> yarn-pkg--retry-0.12.0.tgz
	https://registry.yarnpkg.com/rgba-regex/-/rgba-regex-1.0.0.tgz -> yarn-pkg--rgba-regex-1.0.0.tgz
	https://registry.yarnpkg.com/rgb-regex/-/rgb-regex-1.0.1.tgz -> yarn-pkg--rgb-regex-1.0.1.tgz
	https://registry.yarnpkg.com/rimraf/-/rimraf-2.6.3.tgz -> yarn-pkg--rimraf-2.6.3.tgz
	https://registry.yarnpkg.com/rimraf/-/rimraf-2.7.1.tgz -> yarn-pkg--rimraf-2.7.1.tgz
	https://registry.yarnpkg.com/ripemd160/-/ripemd160-2.0.2.tgz -> yarn-pkg--ripemd160-2.0.2.tgz
	https://registry.yarnpkg.com/run-async/-/run-async-2.4.1.tgz -> yarn-pkg--run-async-2.4.1.tgz
	https://registry.yarnpkg.com/run-queue/-/run-queue-1.0.3.tgz -> yarn-pkg--run-queue-1.0.3.tgz
	https://registry.yarnpkg.com/rxjs/-/rxjs-6.6.3.tgz -> yarn-pkg--rxjs-6.6.3.tgz
	https://registry.yarnpkg.com/safe-buffer/-/safe-buffer-5.1.2.tgz -> yarn-pkg--safe-buffer-5.1.2.tgz
	https://registry.yarnpkg.com/safe-buffer/-/safe-buffer-5.2.1.tgz -> yarn-pkg--safe-buffer-5.2.1.tgz
	https://registry.yarnpkg.com/safer-buffer/-/safer-buffer-2.1.2.tgz -> yarn-pkg--safer-buffer-2.1.2.tgz
	https://registry.yarnpkg.com/safe-regex/-/safe-regex-1.1.0.tgz -> yarn-pkg--safe-regex-1.1.0.tgz
	https://registry.yarnpkg.com/sass-loader/-/sass-loader-8.0.2.tgz -> yarn-pkg--sass-loader-8.0.2.tgz
	https://registry.yarnpkg.com/sass/-/sass-1.32.2.tgz -> yarn-pkg--sass-1.32.2.tgz
	https://registry.yarnpkg.com/sax/-/sax-1.2.4.tgz -> yarn-pkg--sax-1.2.4.tgz
	https://registry.yarnpkg.com/schema-utils/-/schema-utils-0.4.7.tgz -> yarn-pkg--schema-utils-0.4.7.tgz
	https://registry.yarnpkg.com/schema-utils/-/schema-utils-1.0.0.tgz -> yarn-pkg--schema-utils-1.0.0.tgz
	https://registry.yarnpkg.com/schema-utils/-/schema-utils-2.7.1.tgz -> yarn-pkg--schema-utils-2.7.1.tgz
	https://registry.yarnpkg.com/select-hose/-/select-hose-2.0.0.tgz -> yarn-pkg--select-hose-2.0.0.tgz
	https://registry.yarnpkg.com/select/-/select-1.1.2.tgz -> yarn-pkg--select-1.1.2.tgz
	https://registry.yarnpkg.com/selfsigned/-/selfsigned-1.10.8.tgz -> yarn-pkg--selfsigned-1.10.8.tgz
	https://registry.yarnpkg.com/semver/-/semver-5.7.1.tgz -> yarn-pkg--semver-5.7.1.tgz
	https://registry.yarnpkg.com/semver/-/semver-6.3.0.tgz -> yarn-pkg--semver-6.3.0.tgz
	https://registry.yarnpkg.com/semver/-/semver-7.0.0.tgz -> yarn-pkg--semver-7.0.0.tgz
	https://registry.yarnpkg.com/send/-/send-0.17.1.tgz -> yarn-pkg--send-0.17.1.tgz
	https://registry.yarnpkg.com/serialize-javascript/-/serialize-javascript-1.9.1.tgz -> yarn-pkg--serialize-javascript-1.9.1.tgz
	https://registry.yarnpkg.com/serialize-javascript/-/serialize-javascript-4.0.0.tgz -> yarn-pkg--serialize-javascript-4.0.0.tgz
	https://registry.yarnpkg.com/serve-index/-/serve-index-1.9.1.tgz -> yarn-pkg--serve-index-1.9.1.tgz
	https://registry.yarnpkg.com/serve-static/-/serve-static-1.14.1.tgz -> yarn-pkg--serve-static-1.14.1.tgz
	https://registry.yarnpkg.com/set-blocking/-/set-blocking-2.0.0.tgz -> yarn-pkg--set-blocking-2.0.0.tgz
	https://registry.yarnpkg.com/setimmediate/-/setimmediate-1.0.5.tgz -> yarn-pkg--setimmediate-1.0.5.tgz
	https://registry.yarnpkg.com/setprototypeof/-/setprototypeof-1.1.0.tgz -> yarn-pkg--setprototypeof-1.1.0.tgz
	https://registry.yarnpkg.com/setprototypeof/-/setprototypeof-1.1.1.tgz -> yarn-pkg--setprototypeof-1.1.1.tgz
	https://registry.yarnpkg.com/set-value/-/set-value-2.0.1.tgz -> yarn-pkg--set-value-2.0.1.tgz
	https://registry.yarnpkg.com/sha.js/-/sha.js-2.4.11.tgz -> yarn-pkg--sha.js-2.4.11.tgz
	https://registry.yarnpkg.com/shallow-clone/-/shallow-clone-3.0.1.tgz -> yarn-pkg--shallow-clone-3.0.1.tgz
	https://registry.yarnpkg.com/shebang-command/-/shebang-command-1.2.0.tgz -> yarn-pkg--shebang-command-1.2.0.tgz
	https://registry.yarnpkg.com/shebang-command/-/shebang-command-2.0.0.tgz -> yarn-pkg--shebang-command-2.0.0.tgz
	https://registry.yarnpkg.com/shebang-regex/-/shebang-regex-1.0.0.tgz -> yarn-pkg--shebang-regex-1.0.0.tgz
	https://registry.yarnpkg.com/shebang-regex/-/shebang-regex-3.0.0.tgz -> yarn-pkg--shebang-regex-3.0.0.tgz
	https://registry.yarnpkg.com/shell-quote/-/shell-quote-1.7.2.tgz -> yarn-pkg--shell-quote-1.7.2.tgz
	https://registry.yarnpkg.com/signal-exit/-/signal-exit-3.0.3.tgz -> yarn-pkg--signal-exit-3.0.3.tgz
	https://registry.yarnpkg.com/simple-swizzle/-/simple-swizzle-0.2.2.tgz -> yarn-pkg--simple-swizzle-0.2.2.tgz
	https://registry.yarnpkg.com/slash/-/slash-1.0.0.tgz -> yarn-pkg--slash-1.0.0.tgz
	https://registry.yarnpkg.com/slash/-/slash-2.0.0.tgz -> yarn-pkg--slash-2.0.0.tgz
	https://registry.yarnpkg.com/slice-ansi/-/slice-ansi-2.1.0.tgz -> yarn-pkg--slice-ansi-2.1.0.tgz
	https://registry.yarnpkg.com/snapdragon-node/-/snapdragon-node-2.1.1.tgz -> yarn-pkg--snapdragon-node-2.1.1.tgz
	https://registry.yarnpkg.com/snapdragon/-/snapdragon-0.8.2.tgz -> yarn-pkg--snapdragon-0.8.2.tgz
	https://registry.yarnpkg.com/snapdragon-util/-/snapdragon-util-3.0.1.tgz -> yarn-pkg--snapdragon-util-3.0.1.tgz
	https://registry.yarnpkg.com/sockjs-client/-/sockjs-client-1.5.0.tgz -> yarn-pkg--sockjs-client-1.5.0.tgz
	https://registry.yarnpkg.com/sockjs/-/sockjs-0.3.21.tgz -> yarn-pkg--sockjs-0.3.21.tgz
	https://registry.yarnpkg.com/@soda/friendly-errors-webpack-plugin/-/friendly-errors-webpack-plugin-1.8.0.tgz -> yarn-pkg-@soda-friendly-errors-webpack-plugin-1.8.0.tgz
	https://registry.yarnpkg.com/@soda/get-current-script/-/get-current-script-1.0.2.tgz -> yarn-pkg-@soda-get-current-script-1.0.2.tgz
	https://registry.yarnpkg.com/sort-keys/-/sort-keys-1.1.2.tgz -> yarn-pkg--sort-keys-1.1.2.tgz
	https://registry.yarnpkg.com/source-list-map/-/source-list-map-2.0.1.tgz -> yarn-pkg--source-list-map-2.0.1.tgz
	https://registry.yarnpkg.com/source-map-resolve/-/source-map-resolve-0.5.3.tgz -> yarn-pkg--source-map-resolve-0.5.3.tgz
	https://registry.yarnpkg.com/source-map/-/source-map-0.5.7.tgz -> yarn-pkg--source-map-0.5.7.tgz
	https://registry.yarnpkg.com/source-map/-/source-map-0.6.1.tgz -> yarn-pkg--source-map-0.6.1.tgz
	https://registry.yarnpkg.com/source-map/-/source-map-0.7.3.tgz -> yarn-pkg--source-map-0.7.3.tgz
	https://registry.yarnpkg.com/source-map-support/-/source-map-support-0.5.19.tgz -> yarn-pkg--source-map-support-0.5.19.tgz
	https://registry.yarnpkg.com/source-map-url/-/source-map-url-0.4.0.tgz -> yarn-pkg--source-map-url-0.4.0.tgz
	https://registry.yarnpkg.com/spdx-correct/-/spdx-correct-3.1.1.tgz -> yarn-pkg--spdx-correct-3.1.1.tgz
	https://registry.yarnpkg.com/spdx-exceptions/-/spdx-exceptions-2.3.0.tgz -> yarn-pkg--spdx-exceptions-2.3.0.tgz
	https://registry.yarnpkg.com/spdx-expression-parse/-/spdx-expression-parse-3.0.1.tgz -> yarn-pkg--spdx-expression-parse-3.0.1.tgz
	https://registry.yarnpkg.com/spdx-license-ids/-/spdx-license-ids-3.0.7.tgz -> yarn-pkg--spdx-license-ids-3.0.7.tgz
	https://registry.yarnpkg.com/spdy/-/spdy-4.0.2.tgz -> yarn-pkg--spdy-4.0.2.tgz
	https://registry.yarnpkg.com/spdy-transport/-/spdy-transport-3.0.0.tgz -> yarn-pkg--spdy-transport-3.0.0.tgz
	https://registry.yarnpkg.com/split-string/-/split-string-3.1.0.tgz -> yarn-pkg--split-string-3.1.0.tgz
	https://registry.yarnpkg.com/sprintf-js/-/sprintf-js-1.0.3.tgz -> yarn-pkg--sprintf-js-1.0.3.tgz
	https://registry.yarnpkg.com/sshpk/-/sshpk-1.16.1.tgz -> yarn-pkg--sshpk-1.16.1.tgz
	https://registry.yarnpkg.com/ssri/-/ssri-5.3.0.tgz -> yarn-pkg--ssri-5.3.0.tgz
	https://registry.yarnpkg.com/ssri/-/ssri-6.0.1.tgz -> yarn-pkg--ssri-6.0.1.tgz
	https://registry.yarnpkg.com/ssri/-/ssri-7.1.0.tgz -> yarn-pkg--ssri-7.1.0.tgz
	https://registry.yarnpkg.com/stable/-/stable-0.1.8.tgz -> yarn-pkg--stable-0.1.8.tgz
	https://registry.yarnpkg.com/stackframe/-/stackframe-1.2.0.tgz -> yarn-pkg--stackframe-1.2.0.tgz
	https://registry.yarnpkg.com/static-extend/-/static-extend-0.1.2.tgz -> yarn-pkg--static-extend-0.1.2.tgz
	https://registry.yarnpkg.com/statuses/-/statuses-1.5.0.tgz -> yarn-pkg--statuses-1.5.0.tgz
	https://registry.yarnpkg.com/stream-browserify/-/stream-browserify-2.0.2.tgz -> yarn-pkg--stream-browserify-2.0.2.tgz
	https://registry.yarnpkg.com/stream-each/-/stream-each-1.2.3.tgz -> yarn-pkg--stream-each-1.2.3.tgz
	https://registry.yarnpkg.com/stream-http/-/stream-http-2.8.3.tgz -> yarn-pkg--stream-http-2.8.3.tgz
	https://registry.yarnpkg.com/stream-shift/-/stream-shift-1.0.1.tgz -> yarn-pkg--stream-shift-1.0.1.tgz
	https://registry.yarnpkg.com/strict-uri-encode/-/strict-uri-encode-1.1.0.tgz -> yarn-pkg--strict-uri-encode-1.1.0.tgz
	https://registry.yarnpkg.com/string_decoder/-/string_decoder-0.10.31.tgz -> yarn-pkg--string_decoder-0.10.31.tgz
	https://registry.yarnpkg.com/string_decoder/-/string_decoder-1.1.1.tgz -> yarn-pkg--string_decoder-1.1.1.tgz
	https://registry.yarnpkg.com/string_decoder/-/string_decoder-1.3.0.tgz -> yarn-pkg--string_decoder-1.3.0.tgz
	https://registry.yarnpkg.com/string.fromcodepoint/-/string.fromcodepoint-0.2.1.tgz -> yarn-pkg--string.fromcodepoint-0.2.1.tgz
	https://registry.yarnpkg.com/string.prototype.codepointat/-/string.prototype.codepointat-0.2.1.tgz -> yarn-pkg--string.prototype.codepointat-0.2.1.tgz
	https://registry.yarnpkg.com/string.prototype.trimend/-/string.prototype.trimend-1.0.3.tgz -> yarn-pkg--string.prototype.trimend-1.0.3.tgz
	https://registry.yarnpkg.com/string.prototype.trimstart/-/string.prototype.trimstart-1.0.3.tgz -> yarn-pkg--string.prototype.trimstart-1.0.3.tgz
	https://registry.yarnpkg.com/string-width/-/string-width-2.1.1.tgz -> yarn-pkg--string-width-2.1.1.tgz
	https://registry.yarnpkg.com/string-width/-/string-width-3.1.0.tgz -> yarn-pkg--string-width-3.1.0.tgz
	https://registry.yarnpkg.com/string-width/-/string-width-4.2.0.tgz -> yarn-pkg--string-width-4.2.0.tgz
	https://registry.yarnpkg.com/strip-ansi/-/strip-ansi-3.0.1.tgz -> yarn-pkg--strip-ansi-3.0.1.tgz
	https://registry.yarnpkg.com/strip-ansi/-/strip-ansi-4.0.0.tgz -> yarn-pkg--strip-ansi-4.0.0.tgz
	https://registry.yarnpkg.com/strip-ansi/-/strip-ansi-5.2.0.tgz -> yarn-pkg--strip-ansi-5.2.0.tgz
	https://registry.yarnpkg.com/strip-ansi/-/strip-ansi-6.0.0.tgz -> yarn-pkg--strip-ansi-6.0.0.tgz
	https://registry.yarnpkg.com/strip-eof/-/strip-eof-1.0.0.tgz -> yarn-pkg--strip-eof-1.0.0.tgz
	https://registry.yarnpkg.com/strip-final-newline/-/strip-final-newline-2.0.0.tgz -> yarn-pkg--strip-final-newline-2.0.0.tgz
	https://registry.yarnpkg.com/strip-indent/-/strip-indent-2.0.0.tgz -> yarn-pkg--strip-indent-2.0.0.tgz
	https://registry.yarnpkg.com/strip-json-comments/-/strip-json-comments-2.0.1.tgz -> yarn-pkg--strip-json-comments-2.0.1.tgz
	https://registry.yarnpkg.com/stylehacks/-/stylehacks-4.0.3.tgz -> yarn-pkg--stylehacks-4.0.3.tgz
	https://registry.yarnpkg.com/supports-color/-/supports-color-5.5.0.tgz -> yarn-pkg--supports-color-5.5.0.tgz
	https://registry.yarnpkg.com/supports-color/-/supports-color-6.1.0.tgz -> yarn-pkg--supports-color-6.1.0.tgz
	https://registry.yarnpkg.com/supports-color/-/supports-color-7.2.0.tgz -> yarn-pkg--supports-color-7.2.0.tgz
	https://registry.yarnpkg.com/svg2ttf/-/svg2ttf-4.3.0.tgz -> yarn-pkg--svg2ttf-4.3.0.tgz
	https://registry.yarnpkg.com/svgicons2svgfont/-/svgicons2svgfont-9.1.1.tgz -> yarn-pkg--svgicons2svgfont-9.1.1.tgz
	https://registry.yarnpkg.com/svgo/-/svgo-1.3.2.tgz -> yarn-pkg--svgo-1.3.2.tgz
	https://registry.yarnpkg.com/svg-pathdata/-/svg-pathdata-5.0.5.tgz -> yarn-pkg--svg-pathdata-5.0.5.tgz
	https://registry.yarnpkg.com/svgpath/-/svgpath-2.3.0.tgz -> yarn-pkg--svgpath-2.3.0.tgz
	https://registry.yarnpkg.com/svg-tags/-/svg-tags-1.0.0.tgz -> yarn-pkg--svg-tags-1.0.0.tgz
	https://registry.yarnpkg.com/table/-/table-5.4.6.tgz -> yarn-pkg--table-5.4.6.tgz
	https://registry.yarnpkg.com/tapable/-/tapable-1.1.3.tgz -> yarn-pkg--tapable-1.1.3.tgz
	https://registry.yarnpkg.com/terser/-/terser-4.8.0.tgz -> yarn-pkg--terser-4.8.0.tgz
	https://registry.yarnpkg.com/terser-webpack-plugin/-/terser-webpack-plugin-1.4.5.tgz -> yarn-pkg--terser-webpack-plugin-1.4.5.tgz
	https://registry.yarnpkg.com/terser-webpack-plugin/-/terser-webpack-plugin-2.3.8.tgz -> yarn-pkg--terser-webpack-plugin-2.3.8.tgz
	https://registry.yarnpkg.com/text-table/-/text-table-0.2.0.tgz -> yarn-pkg--text-table-0.2.0.tgz
	https://registry.yarnpkg.com/thenify-all/-/thenify-all-1.6.0.tgz -> yarn-pkg--thenify-all-1.6.0.tgz
	https://registry.yarnpkg.com/thenify/-/thenify-3.3.1.tgz -> yarn-pkg--thenify-3.3.1.tgz
	https://registry.yarnpkg.com/thread-loader/-/thread-loader-2.1.3.tgz -> yarn-pkg--thread-loader-2.1.3.tgz
	https://registry.yarnpkg.com/thro-debs/-/thro-debs-1.0.7.tgz -> yarn-pkg--thro-debs-1.0.7.tgz
	https://registry.yarnpkg.com/through2/-/through2-2.0.5.tgz -> yarn-pkg--through2-2.0.5.tgz
	https://registry.yarnpkg.com/through/-/through-2.3.8.tgz -> yarn-pkg--through-2.3.8.tgz
	https://registry.yarnpkg.com/thunky/-/thunky-1.1.0.tgz -> yarn-pkg--thunky-1.1.0.tgz
	https://registry.yarnpkg.com/timers-browserify/-/timers-browserify-2.0.12.tgz -> yarn-pkg--timers-browserify-2.0.12.tgz
	https://registry.yarnpkg.com/timsort/-/timsort-0.3.0.tgz -> yarn-pkg--timsort-0.3.0.tgz
	https://registry.yarnpkg.com/tiny-emitter/-/tiny-emitter-2.1.0.tgz -> yarn-pkg--tiny-emitter-2.1.0.tgz
	https://registry.yarnpkg.com/tmp/-/tmp-0.0.33.tgz -> yarn-pkg--tmp-0.0.33.tgz
	https://registry.yarnpkg.com/to-arraybuffer/-/to-arraybuffer-1.0.1.tgz -> yarn-pkg--to-arraybuffer-1.0.1.tgz
	https://registry.yarnpkg.com/to-fast-properties/-/to-fast-properties-2.0.0.tgz -> yarn-pkg--to-fast-properties-2.0.0.tgz
	https://registry.yarnpkg.com/toidentifier/-/toidentifier-1.0.0.tgz -> yarn-pkg--toidentifier-1.0.0.tgz
	https://registry.yarnpkg.com/to-object-path/-/to-object-path-0.3.0.tgz -> yarn-pkg--to-object-path-0.3.0.tgz
	https://registry.yarnpkg.com/toposort/-/toposort-1.0.7.tgz -> yarn-pkg--toposort-1.0.7.tgz
	https://registry.yarnpkg.com/to-regex-range/-/to-regex-range-2.1.1.tgz -> yarn-pkg--to-regex-range-2.1.1.tgz
	https://registry.yarnpkg.com/to-regex-range/-/to-regex-range-5.0.1.tgz -> yarn-pkg--to-regex-range-5.0.1.tgz
	https://registry.yarnpkg.com/to-regex/-/to-regex-3.0.2.tgz -> yarn-pkg--to-regex-3.0.2.tgz
	https://registry.yarnpkg.com/tough-cookie/-/tough-cookie-2.5.0.tgz -> yarn-pkg--tough-cookie-2.5.0.tgz
	https://registry.yarnpkg.com/transformation-matrix-js/-/transformation-matrix-js-2.7.6.tgz -> yarn-pkg--transformation-matrix-js-2.7.6.tgz
	https://registry.yarnpkg.com/tryer/-/tryer-1.0.1.tgz -> yarn-pkg--tryer-1.0.1.tgz
	https://registry.yarnpkg.com/tslib/-/tslib-1.14.1.tgz -> yarn-pkg--tslib-1.14.1.tgz
	https://registry.yarnpkg.com/ts-pnp/-/ts-pnp-1.2.0.tgz -> yarn-pkg--ts-pnp-1.2.0.tgz
	https://registry.yarnpkg.com/ttf2eot/-/ttf2eot-2.0.0.tgz -> yarn-pkg--ttf2eot-2.0.0.tgz
	https://registry.yarnpkg.com/ttf2woff2-no-gyp/-/ttf2woff2-no-gyp-2.0.5.tgz -> yarn-pkg--ttf2woff2-no-gyp-2.0.5.tgz
	https://registry.yarnpkg.com/ttf2woff/-/ttf2woff-2.0.2.tgz -> yarn-pkg--ttf2woff-2.0.2.tgz
	https://registry.yarnpkg.com/tty-browserify/-/tty-browserify-0.0.0.tgz -> yarn-pkg--tty-browserify-0.0.0.tgz
	https://registry.yarnpkg.com/tunnel-agent/-/tunnel-agent-0.6.0.tgz -> yarn-pkg--tunnel-agent-0.6.0.tgz
	https://registry.yarnpkg.com/tweetnacl/-/tweetnacl-0.14.5.tgz -> yarn-pkg--tweetnacl-0.14.5.tgz
	https://registry.yarnpkg.com/type-check/-/type-check-0.3.2.tgz -> yarn-pkg--type-check-0.3.2.tgz
	https://registry.yarnpkg.com/typedarray/-/typedarray-0.0.6.tgz -> yarn-pkg--typedarray-0.0.6.tgz
	https://registry.yarnpkg.com/type-fest/-/type-fest-0.11.0.tgz -> yarn-pkg--type-fest-0.11.0.tgz
	https://registry.yarnpkg.com/type-fest/-/type-fest-0.6.0.tgz -> yarn-pkg--type-fest-0.6.0.tgz
	https://registry.yarnpkg.com/type-is/-/type-is-1.6.18.tgz -> yarn-pkg--type-is-1.6.18.tgz
	https://registry.yarnpkg.com/@types/anymatch/-/anymatch-1.3.1.tgz -> yarn-pkg-@types-anymatch-1.3.1.tgz
	https://registry.yarnpkg.com/@types/body-parser/-/body-parser-1.19.0.tgz -> yarn-pkg-@types-body-parser-1.19.0.tgz
	https://registry.yarnpkg.com/@types/connect/-/connect-3.4.34.tgz -> yarn-pkg-@types-connect-3.4.34.tgz
	https://registry.yarnpkg.com/@types/connect-history-api-fallback/-/connect-history-api-fallback-1.3.3.tgz -> yarn-pkg-@types-connect-history-api-fallback-1.3.3.tgz
	https://registry.yarnpkg.com/@types/express/-/express-4.17.9.tgz -> yarn-pkg-@types-express-4.17.9.tgz
	https://registry.yarnpkg.com/@types/express-serve-static-core/-/express-serve-static-core-4.17.17.tgz -> yarn-pkg-@types-express-serve-static-core-4.17.17.tgz
	https://registry.yarnpkg.com/@types/glob/-/glob-7.1.3.tgz -> yarn-pkg-@types-glob-7.1.3.tgz
	https://registry.yarnpkg.com/@types/http-proxy/-/http-proxy-1.17.4.tgz -> yarn-pkg-@types-http-proxy-1.17.4.tgz
	https://registry.yarnpkg.com/@types/http-proxy-middleware/-/http-proxy-middleware-0.19.3.tgz -> yarn-pkg-@types-http-proxy-middleware-0.19.3.tgz
	https://registry.yarnpkg.com/@types/json-schema/-/json-schema-7.0.6.tgz -> yarn-pkg-@types-json-schema-7.0.6.tgz
	https://registry.yarnpkg.com/@types/mime/-/mime-2.0.3.tgz -> yarn-pkg-@types-mime-2.0.3.tgz
	https://registry.yarnpkg.com/@types/minimatch/-/minimatch-3.0.3.tgz -> yarn-pkg-@types-minimatch-3.0.3.tgz
	https://registry.yarnpkg.com/@types/minimist/-/minimist-1.2.1.tgz -> yarn-pkg-@types-minimist-1.2.1.tgz
	https://registry.yarnpkg.com/@types/node/-/node-14.14.20.tgz -> yarn-pkg-@types-node-14.14.20.tgz
	https://registry.yarnpkg.com/@types/normalize-package-data/-/normalize-package-data-2.4.0.tgz -> yarn-pkg-@types-normalize-package-data-2.4.0.tgz
	https://registry.yarnpkg.com/@types/q/-/q-1.5.4.tgz -> yarn-pkg-@types-q-1.5.4.tgz
	https://registry.yarnpkg.com/@types/qs/-/qs-6.9.5.tgz -> yarn-pkg-@types-qs-6.9.5.tgz
	https://registry.yarnpkg.com/@types/range-parser/-/range-parser-1.2.3.tgz -> yarn-pkg-@types-range-parser-1.2.3.tgz
	https://registry.yarnpkg.com/@types/serve-static/-/serve-static-1.13.8.tgz -> yarn-pkg-@types-serve-static-1.13.8.tgz
	https://registry.yarnpkg.com/@types/source-list-map/-/source-list-map-0.1.2.tgz -> yarn-pkg-@types-source-list-map-0.1.2.tgz
	https://registry.yarnpkg.com/@types/tapable/-/tapable-1.0.6.tgz -> yarn-pkg-@types-tapable-1.0.6.tgz
	https://registry.yarnpkg.com/@types/uglify-js/-/uglify-js-3.11.1.tgz -> yarn-pkg-@types-uglify-js-3.11.1.tgz
	https://registry.yarnpkg.com/@types/webpack-dev-server/-/webpack-dev-server-3.11.1.tgz -> yarn-pkg-@types-webpack-dev-server-3.11.1.tgz
	https://registry.yarnpkg.com/@types/webpack-sources/-/webpack-sources-2.1.0.tgz -> yarn-pkg-@types-webpack-sources-2.1.0.tgz
	https://registry.yarnpkg.com/@types/webpack/-/webpack-4.41.25.tgz -> yarn-pkg-@types-webpack-4.41.25.tgz
	https://registry.yarnpkg.com/uglify-es/-/uglify-es-3.3.9.tgz -> yarn-pkg--uglify-es-3.3.9.tgz
	https://registry.yarnpkg.com/uglify-js/-/uglify-js-3.4.10.tgz -> yarn-pkg--uglify-js-3.4.10.tgz
	https://registry.yarnpkg.com/uglifyjs-webpack-plugin/-/uglifyjs-webpack-plugin-1.3.0.tgz -> yarn-pkg--uglifyjs-webpack-plugin-1.3.0.tgz
	https://registry.yarnpkg.com/unicode-canonical-property-names-ecmascript/-/unicode-canonical-property-names-ecmascript-1.0.4.tgz -> yarn-pkg--unicode-canonical-property-names-ecmascript-1.0.4.tgz
	https://registry.yarnpkg.com/unicode-match-property-ecmascript/-/unicode-match-property-ecmascript-1.0.4.tgz -> yarn-pkg--unicode-match-property-ecmascript-1.0.4.tgz
	https://registry.yarnpkg.com/unicode-match-property-value-ecmascript/-/unicode-match-property-value-ecmascript-1.2.0.tgz -> yarn-pkg--unicode-match-property-value-ecmascript-1.2.0.tgz
	https://registry.yarnpkg.com/unicode-property-aliases-ecmascript/-/unicode-property-aliases-ecmascript-1.1.0.tgz -> yarn-pkg--unicode-property-aliases-ecmascript-1.1.0.tgz
	https://registry.yarnpkg.com/union-value/-/union-value-1.0.1.tgz -> yarn-pkg--union-value-1.0.1.tgz
	https://registry.yarnpkg.com/uniqs/-/uniqs-2.0.0.tgz -> yarn-pkg--uniqs-2.0.0.tgz
	https://registry.yarnpkg.com/unique-filename/-/unique-filename-1.1.1.tgz -> yarn-pkg--unique-filename-1.1.1.tgz
	https://registry.yarnpkg.com/unique-slug/-/unique-slug-2.0.2.tgz -> yarn-pkg--unique-slug-2.0.2.tgz
	https://registry.yarnpkg.com/uniq/-/uniq-1.0.1.tgz -> yarn-pkg--uniq-1.0.1.tgz
	https://registry.yarnpkg.com/universalify/-/universalify-0.1.2.tgz -> yarn-pkg--universalify-0.1.2.tgz
	https://registry.yarnpkg.com/unpipe/-/unpipe-1.0.0.tgz -> yarn-pkg--unpipe-1.0.0.tgz
	https://registry.yarnpkg.com/unquote/-/unquote-1.1.1.tgz -> yarn-pkg--unquote-1.1.1.tgz
	https://registry.yarnpkg.com/unset-value/-/unset-value-1.0.0.tgz -> yarn-pkg--unset-value-1.0.0.tgz
	https://registry.yarnpkg.com/upath/-/upath-1.2.0.tgz -> yarn-pkg--upath-1.2.0.tgz
	https://registry.yarnpkg.com/upper-case/-/upper-case-1.1.3.tgz -> yarn-pkg--upper-case-1.1.3.tgz
	https://registry.yarnpkg.com/uri-js/-/uri-js-4.4.0.tgz -> yarn-pkg--uri-js-4.4.0.tgz
	https://registry.yarnpkg.com/urix/-/urix-0.1.0.tgz -> yarn-pkg--urix-0.1.0.tgz
	https://registry.yarnpkg.com/url-loader/-/url-loader-2.3.0.tgz -> yarn-pkg--url-loader-2.3.0.tgz
	https://registry.yarnpkg.com/url-parse/-/url-parse-1.5.1.tgz -> yarn-pkg--url-parse-1.5.1.tgz
	https://registry.yarnpkg.com/url/-/url-0.11.0.tgz -> yarn-pkg--url-0.11.0.tgz
	https://registry.yarnpkg.com/use/-/use-3.1.1.tgz -> yarn-pkg--use-3.1.1.tgz
	https://registry.yarnpkg.com/utila/-/utila-0.4.0.tgz -> yarn-pkg--utila-0.4.0.tgz
	https://registry.yarnpkg.com/util-deprecate/-/util-deprecate-1.0.2.tgz -> yarn-pkg--util-deprecate-1.0.2.tgz
	https://registry.yarnpkg.com/util.promisify/-/util.promisify-1.0.0.tgz -> yarn-pkg--util.promisify-1.0.0.tgz
	https://registry.yarnpkg.com/util.promisify/-/util.promisify-1.0.1.tgz -> yarn-pkg--util.promisify-1.0.1.tgz
	https://registry.yarnpkg.com/utils-merge/-/utils-merge-1.0.1.tgz -> yarn-pkg--utils-merge-1.0.1.tgz
	https://registry.yarnpkg.com/util/-/util-0.10.3.tgz -> yarn-pkg--util-0.10.3.tgz
	https://registry.yarnpkg.com/util/-/util-0.11.1.tgz -> yarn-pkg--util-0.11.1.tgz
	https://registry.yarnpkg.com/uuid/-/uuid-3.4.0.tgz -> yarn-pkg--uuid-3.4.0.tgz
	https://registry.yarnpkg.com/validate-npm-package-license/-/validate-npm-package-license-3.0.4.tgz -> yarn-pkg--validate-npm-package-license-3.0.4.tgz
	https://registry.yarnpkg.com/varstream/-/varstream-0.3.2.tgz -> yarn-pkg--varstream-0.3.2.tgz
	https://registry.yarnpkg.com/vary/-/vary-1.1.2.tgz -> yarn-pkg--vary-1.1.2.tgz
	https://registry.yarnpkg.com/vendors/-/vendors-1.0.4.tgz -> yarn-pkg--vendors-1.0.4.tgz
	https://registry.yarnpkg.com/verror/-/verror-1.10.0.tgz -> yarn-pkg--verror-1.10.0.tgz
	https://registry.yarnpkg.com/vm-browserify/-/vm-browserify-1.1.2.tgz -> yarn-pkg--vm-browserify-1.1.2.tgz
	https://registry.yarnpkg.com/@vue/babel-helper-vue-jsx-merge-props/-/babel-helper-vue-jsx-merge-props-1.2.1.tgz -> yarn-pkg-@vue-babel-helper-vue-jsx-merge-props-1.2.1.tgz
	https://registry.yarnpkg.com/@vue/babel-helper-vue-transform-on/-/babel-helper-vue-transform-on-1.0.0.tgz -> yarn-pkg-@vue-babel-helper-vue-transform-on-1.0.0.tgz
	https://registry.yarnpkg.com/@vue/babel-plugin-jsx/-/babel-plugin-jsx-1.0.0.tgz -> yarn-pkg-@vue-babel-plugin-jsx-1.0.0.tgz
	https://registry.yarnpkg.com/@vue/babel-plugin-transform-vue-jsx/-/babel-plugin-transform-vue-jsx-1.2.1.tgz -> yarn-pkg-@vue-babel-plugin-transform-vue-jsx-1.2.1.tgz
	https://registry.yarnpkg.com/@vue/babel-preset-app/-/babel-preset-app-4.5.10.tgz -> yarn-pkg-@vue-babel-preset-app-4.5.10.tgz
	https://registry.yarnpkg.com/@vue/babel-preset-jsx/-/babel-preset-jsx-1.2.4.tgz -> yarn-pkg-@vue-babel-preset-jsx-1.2.4.tgz
	https://registry.yarnpkg.com/@vue/babel-sugar-composition-api-inject-h/-/babel-sugar-composition-api-inject-h-1.2.1.tgz -> yarn-pkg-@vue-babel-sugar-composition-api-inject-h-1.2.1.tgz
	https://registry.yarnpkg.com/@vue/babel-sugar-composition-api-render-instance/-/babel-sugar-composition-api-render-instance-1.2.4.tgz -> yarn-pkg-@vue-babel-sugar-composition-api-render-instance-1.2.4.tgz
	https://registry.yarnpkg.com/@vue/babel-sugar-functional-vue/-/babel-sugar-functional-vue-1.2.2.tgz -> yarn-pkg-@vue-babel-sugar-functional-vue-1.2.2.tgz
	https://registry.yarnpkg.com/@vue/babel-sugar-inject-h/-/babel-sugar-inject-h-1.2.2.tgz -> yarn-pkg-@vue-babel-sugar-inject-h-1.2.2.tgz
	https://registry.yarnpkg.com/@vue/babel-sugar-v-model/-/babel-sugar-v-model-1.2.3.tgz -> yarn-pkg-@vue-babel-sugar-v-model-1.2.3.tgz
	https://registry.yarnpkg.com/@vue/babel-sugar-v-on/-/babel-sugar-v-on-1.2.3.tgz -> yarn-pkg-@vue-babel-sugar-v-on-1.2.3.tgz
	https://registry.yarnpkg.com/@vue/cli-overlay/-/cli-overlay-4.5.10.tgz -> yarn-pkg-@vue-cli-overlay-4.5.10.tgz
	https://registry.yarnpkg.com/@vue/cli-plugin-babel/-/cli-plugin-babel-4.5.10.tgz -> yarn-pkg-@vue-cli-plugin-babel-4.5.10.tgz
	https://registry.yarnpkg.com/@vue/cli-plugin-eslint/-/cli-plugin-eslint-4.5.10.tgz -> yarn-pkg-@vue-cli-plugin-eslint-4.5.10.tgz
	https://registry.yarnpkg.com/@vue/cli-plugin-router/-/cli-plugin-router-4.5.10.tgz -> yarn-pkg-@vue-cli-plugin-router-4.5.10.tgz
	https://registry.yarnpkg.com/@vue/cli-plugin-vuex/-/cli-plugin-vuex-4.5.10.tgz -> yarn-pkg-@vue-cli-plugin-vuex-4.5.10.tgz
	https://registry.yarnpkg.com/@vue/cli-service/-/cli-service-4.5.10.tgz -> yarn-pkg-@vue-cli-service-4.5.10.tgz
	https://registry.yarnpkg.com/@vue/cli-shared-utils/-/cli-shared-utils-4.5.10.tgz -> yarn-pkg-@vue-cli-shared-utils-4.5.10.tgz
	https://registry.yarnpkg.com/@vue/component-compiler-utils/-/component-compiler-utils-3.2.0.tgz -> yarn-pkg-@vue-component-compiler-utils-3.2.0.tgz
	https://registry.yarnpkg.com/@vue/eslint-config-prettier/-/eslint-config-prettier-5.1.0.tgz -> yarn-pkg-@vue-eslint-config-prettier-5.1.0.tgz
	https://registry.yarnpkg.com/vue-eslint-parser/-/vue-eslint-parser-5.0.0.tgz -> yarn-pkg--vue-eslint-parser-5.0.0.tgz
	https://registry.yarnpkg.com/vue-hot-reload-api/-/vue-hot-reload-api-2.3.4.tgz -> yarn-pkg--vue-hot-reload-api-2.3.4.tgz
	https://registry.yarnpkg.com/vue-i18n/-/vue-i18n-8.22.2.tgz -> yarn-pkg--vue-i18n-8.22.2.tgz
	https://registry.yarnpkg.com/vue-loader/-/vue-loader-15.9.6.tgz -> yarn-pkg--vue-loader-15.9.6.tgz
	https://registry.yarnpkg.com/vue-loader/-/vue-loader-16.1.2.tgz -> yarn-pkg--vue-loader-16.1.2.tgz
	https://registry.yarnpkg.com/@vue/preload-webpack-plugin/-/preload-webpack-plugin-1.1.2.tgz -> yarn-pkg-@vue-preload-webpack-plugin-1.1.2.tgz
	https://registry.yarnpkg.com/vue-router/-/vue-router-3.4.9.tgz -> yarn-pkg--vue-router-3.4.9.tgz
	https://registry.yarnpkg.com/vue-style-loader/-/vue-style-loader-4.1.2.tgz -> yarn-pkg--vue-style-loader-4.1.2.tgz
	https://registry.yarnpkg.com/vue-template-compiler/-/vue-template-compiler-2.6.12.tgz -> yarn-pkg--vue-template-compiler-2.6.12.tgz
	https://registry.yarnpkg.com/vue-template-es2015-compiler/-/vue-template-es2015-compiler-1.9.1.tgz -> yarn-pkg--vue-template-es2015-compiler-1.9.1.tgz
	https://registry.yarnpkg.com/vue/-/vue-2.6.12.tgz -> yarn-pkg--vue-2.6.12.tgz
	https://registry.yarnpkg.com/@vue/web-component-wrapper/-/web-component-wrapper-1.2.0.tgz -> yarn-pkg-@vue-web-component-wrapper-1.2.0.tgz
	https://registry.yarnpkg.com/vuex/-/vuex-3.6.0.tgz -> yarn-pkg--vuex-3.6.0.tgz
	https://registry.yarnpkg.com/watchpack-chokidar2/-/watchpack-chokidar2-2.0.1.tgz -> yarn-pkg--watchpack-chokidar2-2.0.1.tgz
	https://registry.yarnpkg.com/watchpack/-/watchpack-1.7.5.tgz -> yarn-pkg--watchpack-1.7.5.tgz
	https://registry.yarnpkg.com/wbuf/-/wbuf-1.7.3.tgz -> yarn-pkg--wbuf-1.7.3.tgz
	https://registry.yarnpkg.com/wcwidth/-/wcwidth-1.0.1.tgz -> yarn-pkg--wcwidth-1.0.1.tgz
	https://registry.yarnpkg.com/@webassemblyjs/ast/-/ast-1.9.0.tgz -> yarn-pkg-@webassemblyjs-ast-1.9.0.tgz
	https://registry.yarnpkg.com/@webassemblyjs/floating-point-hex-parser/-/floating-point-hex-parser-1.9.0.tgz -> yarn-pkg-@webassemblyjs-floating-point-hex-parser-1.9.0.tgz
	https://registry.yarnpkg.com/@webassemblyjs/helper-api-error/-/helper-api-error-1.9.0.tgz -> yarn-pkg-@webassemblyjs-helper-api-error-1.9.0.tgz
	https://registry.yarnpkg.com/@webassemblyjs/helper-buffer/-/helper-buffer-1.9.0.tgz -> yarn-pkg-@webassemblyjs-helper-buffer-1.9.0.tgz
	https://registry.yarnpkg.com/@webassemblyjs/helper-code-frame/-/helper-code-frame-1.9.0.tgz -> yarn-pkg-@webassemblyjs-helper-code-frame-1.9.0.tgz
	https://registry.yarnpkg.com/@webassemblyjs/helper-fsm/-/helper-fsm-1.9.0.tgz -> yarn-pkg-@webassemblyjs-helper-fsm-1.9.0.tgz
	https://registry.yarnpkg.com/@webassemblyjs/helper-module-context/-/helper-module-context-1.9.0.tgz -> yarn-pkg-@webassemblyjs-helper-module-context-1.9.0.tgz
	https://registry.yarnpkg.com/@webassemblyjs/helper-wasm-bytecode/-/helper-wasm-bytecode-1.9.0.tgz -> yarn-pkg-@webassemblyjs-helper-wasm-bytecode-1.9.0.tgz
	https://registry.yarnpkg.com/@webassemblyjs/helper-wasm-section/-/helper-wasm-section-1.9.0.tgz -> yarn-pkg-@webassemblyjs-helper-wasm-section-1.9.0.tgz
	https://registry.yarnpkg.com/@webassemblyjs/ieee754/-/ieee754-1.9.0.tgz -> yarn-pkg-@webassemblyjs-ieee754-1.9.0.tgz
	https://registry.yarnpkg.com/@webassemblyjs/leb128/-/leb128-1.9.0.tgz -> yarn-pkg-@webassemblyjs-leb128-1.9.0.tgz
	https://registry.yarnpkg.com/@webassemblyjs/utf8/-/utf8-1.9.0.tgz -> yarn-pkg-@webassemblyjs-utf8-1.9.0.tgz
	https://registry.yarnpkg.com/@webassemblyjs/wasm-edit/-/wasm-edit-1.9.0.tgz -> yarn-pkg-@webassemblyjs-wasm-edit-1.9.0.tgz
	https://registry.yarnpkg.com/@webassemblyjs/wasm-gen/-/wasm-gen-1.9.0.tgz -> yarn-pkg-@webassemblyjs-wasm-gen-1.9.0.tgz
	https://registry.yarnpkg.com/@webassemblyjs/wasm-opt/-/wasm-opt-1.9.0.tgz -> yarn-pkg-@webassemblyjs-wasm-opt-1.9.0.tgz
	https://registry.yarnpkg.com/@webassemblyjs/wasm-parser/-/wasm-parser-1.9.0.tgz -> yarn-pkg-@webassemblyjs-wasm-parser-1.9.0.tgz
	https://registry.yarnpkg.com/@webassemblyjs/wast-parser/-/wast-parser-1.9.0.tgz -> yarn-pkg-@webassemblyjs-wast-parser-1.9.0.tgz
	https://registry.yarnpkg.com/@webassemblyjs/wast-printer/-/wast-printer-1.9.0.tgz -> yarn-pkg-@webassemblyjs-wast-printer-1.9.0.tgz
	https://registry.yarnpkg.com/webpack-bundle-analyzer/-/webpack-bundle-analyzer-3.9.0.tgz -> yarn-pkg--webpack-bundle-analyzer-3.9.0.tgz
	https://registry.yarnpkg.com/webpack-chain/-/webpack-chain-6.5.1.tgz -> yarn-pkg--webpack-chain-6.5.1.tgz
	https://registry.yarnpkg.com/webpack-dev-middleware/-/webpack-dev-middleware-3.7.3.tgz -> yarn-pkg--webpack-dev-middleware-3.7.3.tgz
	https://registry.yarnpkg.com/webpack-dev-server/-/webpack-dev-server-3.11.1.tgz -> yarn-pkg--webpack-dev-server-3.11.1.tgz
	https://registry.yarnpkg.com/webpack-iconfont-plugin-nodejs/-/webpack-iconfont-plugin-nodejs-1.0.17.tgz -> yarn-pkg--webpack-iconfont-plugin-nodejs-1.0.17.tgz
	https://registry.yarnpkg.com/webpack-log/-/webpack-log-2.0.0.tgz -> yarn-pkg--webpack-log-2.0.0.tgz
	https://registry.yarnpkg.com/webpack-merge/-/webpack-merge-4.2.2.tgz -> yarn-pkg--webpack-merge-4.2.2.tgz
	https://registry.yarnpkg.com/webpack-sources/-/webpack-sources-1.4.3.tgz -> yarn-pkg--webpack-sources-1.4.3.tgz
	https://registry.yarnpkg.com/webpack/-/webpack-4.44.2.tgz -> yarn-pkg--webpack-4.44.2.tgz
	https://registry.yarnpkg.com/websocket-driver/-/websocket-driver-0.7.4.tgz -> yarn-pkg--websocket-driver-0.7.4.tgz
	https://registry.yarnpkg.com/websocket-extensions/-/websocket-extensions-0.1.4.tgz -> yarn-pkg--websocket-extensions-0.1.4.tgz
	https://registry.yarnpkg.com/which-module/-/which-module-2.0.0.tgz -> yarn-pkg--which-module-2.0.0.tgz
	https://registry.yarnpkg.com/which/-/which-1.3.1.tgz -> yarn-pkg--which-1.3.1.tgz
	https://registry.yarnpkg.com/which/-/which-2.0.2.tgz -> yarn-pkg--which-2.0.2.tgz
	https://registry.yarnpkg.com/word-wrap/-/word-wrap-1.2.3.tgz -> yarn-pkg--word-wrap-1.2.3.tgz
	https://registry.yarnpkg.com/worker-farm/-/worker-farm-1.7.0.tgz -> yarn-pkg--worker-farm-1.7.0.tgz
	https://registry.yarnpkg.com/wrap-ansi/-/wrap-ansi-5.1.0.tgz -> yarn-pkg--wrap-ansi-5.1.0.tgz
	https://registry.yarnpkg.com/wrap-ansi/-/wrap-ansi-6.2.0.tgz -> yarn-pkg--wrap-ansi-6.2.0.tgz
	https://registry.yarnpkg.com/wrappy/-/wrappy-1.0.2.tgz -> yarn-pkg--wrappy-1.0.2.tgz
	https://registry.yarnpkg.com/write/-/write-1.0.3.tgz -> yarn-pkg--write-1.0.3.tgz
	https://registry.yarnpkg.com/ws/-/ws-6.2.2.tgz -> yarn-pkg--ws-6.2.2.tgz
	https://registry.yarnpkg.com/xmldom/-/xmldom-0.1.31.tgz -> yarn-pkg--xmldom-0.1.31.tgz
	https://registry.yarnpkg.com/xtend/-/xtend-4.0.2.tgz -> yarn-pkg--xtend-4.0.2.tgz
	https://registry.yarnpkg.com/@xtuc/ieee754/-/ieee754-1.2.0.tgz -> yarn-pkg-@xtuc-ieee754-1.2.0.tgz
	https://registry.yarnpkg.com/@xtuc/long/-/long-4.2.2.tgz -> yarn-pkg-@xtuc-long-4.2.2.tgz
	https://registry.yarnpkg.com/y18n/-/y18n-4.0.1.tgz -> yarn-pkg--y18n-4.0.1.tgz
	https://registry.yarnpkg.com/yallist/-/yallist-2.1.2.tgz -> yarn-pkg--yallist-2.1.2.tgz
	https://registry.yarnpkg.com/yallist/-/yallist-3.1.1.tgz -> yarn-pkg--yallist-3.1.1.tgz
	https://registry.yarnpkg.com/yallist/-/yallist-4.0.0.tgz -> yarn-pkg--yallist-4.0.0.tgz
	https://registry.yarnpkg.com/yargs-parser/-/yargs-parser-13.1.2.tgz -> yarn-pkg--yargs-parser-13.1.2.tgz
	https://registry.yarnpkg.com/yargs-parser/-/yargs-parser-18.1.3.tgz -> yarn-pkg--yargs-parser-18.1.3.tgz
	https://registry.yarnpkg.com/yargs/-/yargs-13.3.2.tgz -> yarn-pkg--yargs-13.3.2.tgz
	https://registry.yarnpkg.com/yargs/-/yargs-15.4.1.tgz -> yarn-pkg--yargs-15.4.1.tgz
	https://registry.yarnpkg.com/yorkie/-/yorkie-2.0.0.tgz -> yarn-pkg--yorkie-2.0.0.tgz
"

SRC_URI+="
	https://github.com/v2rayA/v2rayA/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+v2ray xray systemd"
REQUIRED_USE="|| ( v2ray xray )"

DEPEND=""
RDEPEND="${DEPEND}
	v2ray? ( || (
		net-proxy/v2ray
		net-proxy/v2ray-bin
	) )
	xray? ( >=net-proxy/Xray-1.4.3 )
"
BDEPEND="
	dev-lang/go
	>=net-libs/nodejs-14.17.5-r1
	sys-apps/yarn
"

src_unpack() {
	local a
	local fn

	mkdir -p "${WORKDIR}/yarn-cache" || die

	for a in ${A} ; do
		case "${a}" in
			yarn-pkg*)
				# Yarn artifact
				fn="${a#yarn-pkg--}"
				fn="${fn#yarn-pkg-}"
				ln -s "${DISTDIR}/${a}" "${WORKDIR}/yarn-cache/${fn}" || die
				;;
			"${P}.tar.gz")
				# Fallback to the default unpacker.
				unpack "${a}"
				;;
		esac
	done

	go-module_setup_proxy
}

src_prepare() {
	echo "yarn-offline-mirror \"${WORKDIR}/yarn-cache\"" >> "${WORKDIR}/v2rayA-${PV}/gui/.yarnrc" || die
	cd "${WORKDIR}/v2rayA-${PV}/gui"
	yarn install --check-files --offline|| die
	default
}

src_compile() {
	cd "${WORKDIR}/v2rayA-${PV}/gui"
	#yarn --check-files
	OUTPUT_DIR="${WORKDIR}/v2rayA-${PV}/service/server/router/web" yarn build || die

	cd "${WORKDIR}/v2rayA-${PV}/service"
	go build -ldflags '-X github.com/v2rayA/v2rayA/conf.Version='${PV}' -s -w' -o v2raya || die
}

src_install() {
	default
	dobin "${WORKDIR}"/v2rayA-${PV}/service/v2raya

	if use systemd; then
		systemd_newunit "${WORKDIR}"/v2rayA-${PV}/install/universal/v2raya.service v2raya.service
		systemd_newunit "${WORKDIR}"/v2rayA-${PV}/install/universal/v2raya@.service v2raya@.service
	fi

	#thanks to @Universebenzene
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newinitd "${FILESDIR}"/${PN}-user.initd ${PN}-user
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	newconfd "${FILESDIR}"/${PN}-user.confd ${PN}-user

	newicon -s 512 "${WORKDIR}"/v2rayA-${PV}/gui/public/img/icons/android-chrome-512x512.png v2raya.png
	domenu "${WORKDIR}"/v2rayA-${PV}/install/universal/v2raya.desktop
}
