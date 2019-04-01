//
//  CEViewControllerInformations.swift
//  CuriosityEye
//
//  Created by Camille Tilmont on 28/10/2017.
//  Copyright © 2017 Camille Tilmont. All rights reserved.
//

import UIKit

class CEViewControllerInformations: UIViewController {
    @IBOutlet var spaceTextInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        spaceTextInfo.text = """

        Mast Camera (MastCam) est un ensemble de deux caméras fixées au sommet du mât du rover MSL à une hauteur d'environ 1,97 mètre au-dessus du sol pouvant fournir des images en couleurs, en lumière visible et en proche infrarouge. Elles sont utilisées pour identifier les caractéristiques géologiques des terrains environnants et reconstituer la topographie du site. Elles enregistrent également les phénomènes météorologiques (nuages, givre, poussières soulevées par le vent) et apportent leur contribution dans les tâches de navigation. Elles peuvent observer des détails d'une taille allant jusqu'à 0,15 mm. Selon les plans initiaux, les deux caméras devaient être identiques et munies d'un zoom avec une focale allant de 6,5 à 100 mm (rapport de 15). À la suite d'arbitrages budgétaires et après plusieurs rebondissements, deux caméras à focale fixes ont été finalement sélectionnées : à gauche, une caméra « grand angle » de focale de 34 mm (baptisée Mastcam 34) ouvrant à f/8 et couvrant un champ de 15°x15°, et à droite, une caméra dotée d'un téléobjectif de 100 mm (baptisée Mastcam 100) ouvrant à f/10 et couvrant un champ de 5,1°x5,1°. La caméra grand angle peut réaliser un panorama de 360° en 25 minutes par superposition de 150 photos.
        
        Chemistry and Camera Complex (ChemCam) est un instrument qui permet d'analyser à distance la nature, la composition et l’état d'altération des roches. Il utilise pour la première fois sur un engin spatial la technique d'analyse spectroscopique induite par ablation laser : un laser pulsé tire sur la roche à analyser provoquant la fusion de sa couche superficielle et générant un plasma. La lumière de désexcitation émise dans le visible et l'ultraviolet est collectée par un télescope et envoyée à des spectromètres qui établissent la composition chimique élémentaire de la roche. Avec une portée de 7 mètres, cet instrument permet d'analyser rapidement plusieurs échantillons de sol ou de roche et de déterminer s'il y a lieu de poursuivre l'analyse avec d'autres instruments. De plus son utilisation consomme relativement peu d'énergie. CHEMCAM est composé d'une partie optique montée au sommet du mât du rover et de trois spectromètres abrités dans le corps du rover avec la majorité de l'électronique. La partie optique comprend le laser qui envoie des impulsions venant frapper la cible sur un diamètre de 0,3 à 0,6 mm durant 55 nanosecondes pour effectuer des mesures par le procédé LIBS (Laser-Induced Breakdown Spectrometer). De 50 à 70 impulsions successives sont nécessaires pour obtenir une analyse spectrale correcte de la roche. L'optique de 110 mm utilisée pour viser la cible avec le laser permet de recueillir l'image renvoyée et de la transmettre par fibre optique aux spectromètres. Les spectromètres analysent la lumière sur une bande allant de 240 à 850 nm avec une résolution de 0,09 à 0,3 nm. La partie optique comprend également une caméra (Remote Micro-Imager ou RMI) fournissant une image du contexte de l'échantillon analysé.
        
        Mars Hand Lens Imager (MAHLI) est une caméra microscope montée sur le porte-outils situé au bout du bras du rover. Elle permet de caractériser la composition et la microstructure des roches, du sol, du givre et de la glace identifiables à une échelle comprise entre le micron et le centimètre. Elle fournit des images en couleurs en lumière visible. La tête de la caméra est équipée de 4 LED en lumière blanche pour éclairer la cible lorsque celle-ci est plongée dans l'ombre ou de nuit et 2 LED en ultraviolet pour produire de la fluorescence et détecter ainsi les minéraux carbonatés et les évaporites. La caméra peut faire une mise au point de 20,5 mm à l'infini, son champ optique étant compris entre 34 et 39,4°. Au plus près de l'objet photographié le champ couvert est de 18 × 24 mm et la résolution maximale de 15 micromètres par pixel grâce à un capteur CCD de 1600x1200 pixels. Deux capteurs permettent au système d'éviter un contact direct de l'optique avec l'objet photographié. MAHLI dispose d'un autofocus mais l'équipe au sol peut lui demander d'acquérir une séquence de 8 images du même objet avec des mises au point différentes pour obtenir une image tridimensionnelle car la profondeur de champ au plus près est de 1,6 mm (et peut ainsi réaliser une image avec une grande profondeur de champ grâce à un logiciel de focus stacking embarqué). MAHLI peut être également utilisée pour inspecter le rover ou la configuration du terrain : sa position en bout de bras lui permet d'être placée dans une position plus haute que les caméras MASTCAM. Le spectre lumineux couvert va de 380 à 680 nm. La caméra a une capacité vidéo de 7 images par seconde au format 720p (1280x720 pixels).
        
        Mars Descent Imager (MARDI) est une caméra en couleur montée sous le châssis du rover et a été chargée de cartographier le site d'atterrissage durant la descente vers le sol martien. Elle couvre un champ de 70°x55°. La caméra a pris environ 500 photos (5 photos par seconde) à partir d'une altitude de 3,7 km (zone photographiée de 3 × 4 km) jusqu'à l'atterrissage (zone photographiée de 1 × 0,75 mètre) avec une résolution croissante de 2,5 mètres par pixel à 1,5 mm par pixel, soit sur une période de 2 minutes. La caméra comporte une mémoire de 8 gigabits qui permet théoriquement de stocker 4 000 photos en mode RAW. Les photos doivent être enregistrées dans ce mode et compressées avant leur transmission à Terre bien que la caméra puisse réaliser cette compression en temps réel. Ces photos ont été utilisées par l'équipe au sol pour situer le site d'atterrissage et identifier les sites intéressants sur le plan géologique se trouvant à proximité du lieu d'atterrissage. Il était prévu que les mouvements de giration à grande vitesse angulaire qui animeront la sonde durant la descente sous parachute et les vibrations générées par les moteurs-fusées de l'étage de descente rendent un grand nombre de photos floues malgré un temps d'exposition de 1,3 milliseconde. La caméra a une résolution utile de 1600x1200 pixels. MARDI avait été éliminée de la charge utile de MSL lors des premiers arbitrages financiers en 2007 avant d'être réintégrée par la suite
        
          Les caméras de navigation, bien que ne faisant pas partie des instruments scientifiques, fournissent dans certains cas des images exploitées à des fins scientifiques. Quatre paires redondantes, dites Hazcam (Hazard Avoidance Cameras), sont montées deux par deux à l'avant et à l'arrière du corps du rover. Ces appareils dotés d'un objectif fisheye avec un champ optique de 124° fournissent des images en noir et blanc permettant de reconstituer une image tridimensionnelle de ce qui se situe devant et derrière le rover jusqu'à 3 mètres de distance et sur une largeur de 4 mètres. Deux autres paires de caméras (Navigation Cameras ou Navcams) montées au sommet du mât du rover de part et d'autre des caméras à usage scientifique MASTCAM, permettent d'obtenir des panoramiques en relief sur un champ de 45°
        
        """
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
