# Legacy catalogue source manifest

- Archive date: 2026-07-12
- Origin commit: `1078f3e1176c2432701c7a4d702bb5d80e39645d`
- Runtime source entry count: 1762
- Baseline startup passes: 51
- Baseline processed entries per clean install: 89862

| Original path | Bytes | SHA-256 |
| --- | ---: | --- |
| `lib/database/seed_data.dart` | 13077 | `DD6FB14A5BCE2CB733C302154334BD5C80B531D1852EEA1C82612AAB13C92CB6` |
| `lib/services/exercise_catalog_context_service.dart` | 336112 | `3E4A78198FB2A0191FE02386A8C2B93924E0C399467FC9E66FFB99E1FDAEE0B0` |
| `lib/services/exercise_catalog_detail_service.dart` | 54616 | `D0A2C25DF8C0D9AB259CA64BD968CABB5B6775588EC5A7B2EB304F9C65DCAE2B` |
| `lib/services/v100_catalog_domain_data.dart` | 277377 | `17B6A6F82A002D97AAA6F169E77D1F61EB2BF605780C2192F8163EE3D2B9F99B` |
| `lib/services/exercise_taxonomy_service.dart` | 12494 | `473B2ED5FEE30F843BF2ECE0322E1244548BA72CD2905CE557DDCEE852205B14` |
| `lib/services/exercise_muscle_node_service.dart` | 9109 | `FBF139E00351B841EEF04F049BD13A822A0F685E3B521246034230EE5F238274` |
| `lib/services/exercise_filter_service.dart` | 43926 | `C90DD0AFBEC88B274F95D2EE828FC2594A5E3E6833B6E85554F3F90475149BF0` |
| `lib/services/exercise_capability_service.dart` | 6814 | `B2FB0A56CDB83D0225152A363C9BF21C824E503FD4B61313EE1992F54A24C9F4` |
| `lib/services/training_architecture.dart` | 97262 | `1C666C22D5FFD50B94996892EC3780CF8175182363BA6579A247094301D79DC6` |
| `lib/services/catalog_quality_gate_service.dart` | 45784 | `D7140347BAA6F82AAEF3F0A97BB28C149BE218C39F8B1676E832AA11F2DC7075` |

The first file also contains old profile goal and workout type seed definitions.
Those independent runtime uses were separated before the archive was finalized,
so the file is now reachable only from offline legacy catalogue services and
tests. All listed files have no production import path from the app entrypoint,
database startup, screens or widgets. Git history is the immutable archive of
their original content; this manifest prevents a second large copy in the
repository.
