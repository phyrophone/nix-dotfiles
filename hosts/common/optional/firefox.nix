{ ... }:
let
  # Check about:support for extension/add-on ID strings.
  extensions = [
    "adnauseam@rednoise.org"
    "78272b6fa58f4a1abaac99321d503a20@proton.me" # Proton Pass
    "{c88c53f2-6af9-4575-bea0-48e206743baf}" # Music Score Downloader
  ];
in
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-GB" ];

    # Check about:policies#documentation for options.
    policies = {
      #### DEBLOAT ###
      DisableFirefoxStudies = true;
      #DisableFirefoxScreenshots = true;
      DontCheckDefaultBrowser = true;
      UserMessaging = {
        ExtensionRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        FirefoxLabs = true;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };

      #### SECURITY ###
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;

      #### PRIVACY ###
      DisableTelemetry = true;
      DisablePocket = true;
      NetworkPrediction = false;

      Cookies = {
        Allow = [
          "https://github.com"
          "https://gitlab.com"
          "https://codeberg.org"
          "https://sr.ht"
          "http://127.0.0.1"
          "https://127.0.0.1"
          "http://localhost"
          "https://localhost"
          "https://192.168.1.1"

          # specific sites
          "..."
        ];
      };

      SearchEngines = {
        Remove = [
          "eBay"
          "Google"
          "Bing"
          "Ecosia"
          "Wikipedia (en)"
          "Perplexity"
        ];
        Add = [
          {
            "Name" = "DuckDuckGo";
            "URLTemplate" = "https://duckduckgo.com/?q={searchTerms}&ia=web&assist=false";
            "IconURL" = "https://duckduckgo.com/favicon.ico";
            "Alias" = "ddg";
            "Description" = "Duckduckgo without AI integrations";
          }
          {
            "Name" = "Nix Packages";
            "URLTemplate" = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
            "IconURL" = "https://nixos.org/favicon.ico";
            "Alias" = "nixp";
            "Description" = "Nix Packages";
          }
          {
            "Name" = "Nix Options";
            "URLTemplate" = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
            "IconURL" = "https://nixos.org/favicon.ico";
            "Alias" = "nixo";
            "Description" = "Nix Options";
          }
          {
            "Name" = "My NixOS";
            "URLTemplate" = "https://mynixos.com/search?q={searchTerms}";
            "IconURL" = "https://mynixos.com/favicon.ico";
            "Alias" = "mynix";
            "Description" = "mynixos.com";
          }
        ];
        Default = "DuckDuckGo";
      };
      SearchSuggestEnabled = false;

      ExtensionSettings =
        (builtins.listToAttrs (
          builtins.map (id: {
            name = id;
            value = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";
              installation_mode = "force_installed";
            };
          }) extensions
        ))
        // {
          "queryamoid@kaply.com" = {
            # Gets the addon_id of a extension from https://addons.mozilla.org
            install_url = "https://github.com/mkaply/queryamoid/releases/download/v0.1/query_amo_addon_id-0.1-fx.xpi";
            installation_mode = "force_installed";
          };
          "*".installation_mode = "blocked"; # Uninstall old/undeclared extensions
        };
    };

    preferences = {

      #### FEATURES ###
      "layout.spellcheckDefault" = 1;
      # Use the systems native filechooser portal
      "widget.use-xdg-desktop-portal.file-picker" = 1;

      "media.webrtc.camera.allow-pipewire" = true;
      "browser.download.always_ask_before_handling_new_types" = true;

      ### QoL
      "general.autoScroll" = true;
      "browser.tabs.searchclipboardfor.middleclick" = false;

      #### DEBLOAT ###
      "browser.discovery.enabled" = false;
      "app.shield.optoutstudies.enabled" = false;
      "browser.topsites.contile.enabled" = false;
      "browser.urlbar.suggest.quicksuggest.sponsored" = false;
      "browser.urlbar.trending.featureGate" = false;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
      "browser.newtabpage.activity-stream.feeds.snippets" = false;
      "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
      "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
      "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
      "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.system.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      # Privacy: Disable automatic opening in new windows (manually still works)
      # https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/9881
      "browser.link.open_newwindow" = 3;
      # Privacy: Set all window open modes to abide above method
      "browser.link.open_newwindow.restriction" = 0;

      #### PRIVACY ###
      "privacy.resistFingerprinting" = "true";
      # disable sending downloaded files to the internet
      "browser.safebrowsing.downloads.remote.enabled" = false;
      "network.dns.disablePrefetch" = false;
      # redundancy: disable network prefetching
      "network.predictor.enabled" = false;
      # disable preloading websites when hovering over links
      "network.http.speculative-parallel-limit" = 0;
      # disable connecting to bookmarks when hovering over them
      "browser.places.speculativeConnect.enabled" = "false";
      "privacy.globalprivacycontrol.enabled" = true;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = true;
      "privacy.fingerprintingProtection" = true;

      "browser.contentblocking.category" = "standard";
      "extensions.pocket.enabled" = false;

      "browser.search.suggest.enabled" = false;
      "browser.search.suggest.enabled.private" = false;
      "browser.urlbar.suggest.searches" = false;
      "browser.urlbar.suggest.history" = false;
      "browser.urlbar.suggest.recentsearches" = false;
      "browser.newtabpage.activity-stream.feeds.topsites" = false;
      "browser.newtabpage.activity-stream.feeds.system.topsites" = false;

      # store media in cache only on private browsing
      "browser.privatebrowsing.forceMediaMemoryCache" = true;
      "network.http.referer.XOriginTrimmingPolicy" = 2;
      # Privacy: Disable CSP reporting
      # https://bugzilla.mozilla.org/show_bug.cgi?id=1964249
      "security.csp.reporting.enabled" = false;

      #### SECURITY ###
      #"browser.formfill.enable" = false;
      "pdfjs.enableScripting" = false;
      #"signon.autofillForms" = false
      # UNCLEAR
      "signon.formlessCapture.enabled" = false;
      # prevent scripts from moving or resizing windows
      "dom.disable_window_move_resize" = true;
      # Security: Disable remote debugging feature
      # https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/16222
      "devtools.debugger.remote-enabled" = false;
      # Security: Restrict directories from which extensions can be loaded (Unclear)
      # https://archive.is/DYjAM
      "extensions.enabledScopes" = 5;

      #### SSL ###
      # Security: Require safe SSL negotiation to avoid potentially MITMed sites
      "security.ssl.require_safe_negotiation" = true;
      # Security: Disable TLS1.3 0-RTT as key encryption may not be forward secret
      # https://github.com/tlswg/tls13-spec/issues/1001
      "security.tls.enable_0rtt_data" = 2;
      # Security: Enable strict public key pinning, prevents some MITM attacks
      "security.cert_pinning.enforcement_level" = 2;
      # Security: Enable CRLite to ensure that revoked certificates are detected
      "security.pki.crlite_mode" = 2;
      # Security: Treat unsafe negotiation as broken
      # https://wiki.mozilla.org/Security:Renegotiation
      # https://bugzilla.mozilla.org/1353705
      "security.ssl.treat_unsafe_negotiation_as_broken" = true;
      #  Security: Display more information on Insecure Connection warning pages
      # Test: https://badssl.com
      "browser.xul.error_pages.expert_bad_cert" = true;
    };
  };
}
