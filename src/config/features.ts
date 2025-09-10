import { FiMap, FiStar, FiCompass } from "react-icons/fi";
import type { Feature } from "./types";

export const features: Feature[] = [
  {
    title: "Akıllı Rota Önerileri",
    description:
      "Gezmek istediğin şehre özel en kısa ve en keyifli rotaları keşfet. Zamanını verimli kullan, daha çok yer gör.",
    icon: FiCompass,
  },
  {
    title: "Favori Mekanlarını Kaydet",
    description:
      "Beğendiğin restoran, müze veya parkları tek dokunuşla favorilerine ekle. Sonraki seyahatlerinde kolayca ulaş.",
    icon: FiStar,
  },
  {
    title: "Offline Harita Desteği",
    description:
      "İnternetin olmasa bile rotalarını görüntüle ve kaybolmadan gez. Seyahat ederken özgür ol!",
    icon: FiMap,
  },
];
