'use client';

import { useEffect, useRef } from 'react';
import * as THREE from 'three';

const labels = ['CLIENT', 'SERVER', 'FIREWALL', 'DATABASE', 'API', 'SECURITY SCANNER'];

export function NetworkHero({ onScannerClick }: { onScannerClick: () => void }) {
  const mountRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const mount = mountRef.current;
    if (!mount) return;

    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(60, mount.clientWidth / mount.clientHeight, 0.1, 100);
    camera.position.z = 4;

    const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
    renderer.setSize(mount.clientWidth, mount.clientHeight);
    mount.appendChild(renderer.domElement);

    const group = new THREE.Group();
    scene.add(group);

    const points = [
      new THREE.Vector3(-1.4, 0.5, 0),
      new THREE.Vector3(1.2, 0.8, 0.4),
      new THREE.Vector3(0, 0, -1.3),
      new THREE.Vector3(1, -0.9, -0.3),
      new THREE.Vector3(-1.1, -0.6, 1),
      new THREE.Vector3(0, 1.3, 1)
    ];

    const spheres: THREE.Mesh[] = [];
    points.forEach((p, idx) => {
      const mat = new THREE.MeshStandardMaterial({ color: idx === 5 ? 0x22c55e : 0x22d3ee, emissive: idx === 5 ? 0x22c55e : 0x22d3ee, emissiveIntensity: 0.8 });
      const sphere = new THREE.Mesh(new THREE.SphereGeometry(0.07, 12, 12), mat);
      sphere.position.copy(p);
      sphere.userData.label = labels[idx];
      group.add(sphere);
      spheres.push(sphere);
    });

    const edges = [[0,1], [1,3], [3,4], [4,0], [2,1], [2,4], [5,0], [5,1], [5,2]];
    edges.forEach(([a, b]) => {
      const geo = new THREE.BufferGeometry().setFromPoints([points[a], points[b]]);
      const line = new THREE.Line(geo, new THREE.LineBasicMaterial({ color: 0x22d3ee, transparent: true, opacity: 0.5 }));
      group.add(line);
    });

    const particlesGeo = new THREE.BufferGeometry();
    const positions = new Float32Array(180);
    for (let i = 0; i < 180; i += 3) {
      positions[i] = (Math.random() - 0.5) * 4;
      positions[i + 1] = (Math.random() - 0.5) * 4;
      positions[i + 2] = (Math.random() - 0.5) * 4;
    }
    particlesGeo.setAttribute('position', new THREE.BufferAttribute(positions, 3));
    const particles = new THREE.Points(particlesGeo, new THREE.PointsMaterial({ color: 0x22d3ee, size: 0.02 }));
    scene.add(particles);

    const light = new THREE.PointLight(0x22d3ee, 2, 20);
    light.position.set(3, 2, 4);
    scene.add(light);
    scene.add(new THREE.AmbientLight(0xffffff, 0.4));

    const raycaster = new THREE.Raycaster();
    const mouse = new THREE.Vector2();
    const tooltip = document.createElement('div');
    tooltip.className = 'pointer-events-none absolute rounded border border-cyan-500/40 bg-black/80 px-2 py-1 text-[10px] text-cyan-300 hidden';
    mount.style.position = 'relative';
    mount.appendChild(tooltip);

    const onMove = (e: MouseEvent) => {
      const rect = mount.getBoundingClientRect();
      mouse.x = ((e.clientX - rect.left) / rect.width) * 2 - 1;
      mouse.y = -((e.clientY - rect.top) / rect.height) * 2 + 1;
      raycaster.setFromCamera(mouse, camera);
      const intersects = raycaster.intersectObjects(spheres);
      if (intersects[0]) {
        tooltip.textContent = intersects[0].object.userData.label;
        tooltip.style.left = `${e.clientX - rect.left + 12}px`;
        tooltip.style.top = `${e.clientY - rect.top + 12}px`;
        tooltip.classList.remove('hidden');
      } else tooltip.classList.add('hidden');
    };

    const onClick = () => {
      raycaster.setFromCamera(mouse, camera);
      const hit = raycaster.intersectObjects(spheres)[0];
      if (hit?.object.userData.label === 'SECURITY SCANNER') onScannerClick();
    };

    mount.addEventListener('mousemove', onMove);
    mount.addEventListener('click', onClick);

    const animate = () => {
      group.rotation.y += 0.004;
      particles.rotation.y += 0.001;
      renderer.render(scene, camera);
      requestAnimationFrame(animate);
    };
    animate();

    const onResize = () => {
      camera.aspect = mount.clientWidth / mount.clientHeight;
      camera.updateProjectionMatrix();
      renderer.setSize(mount.clientWidth, mount.clientHeight);
    };
    window.addEventListener('resize', onResize);

    return () => {
      window.removeEventListener('resize', onResize);
      mount.removeEventListener('mousemove', onMove);
      mount.removeEventListener('click', onClick);
      mount.removeChild(renderer.domElement);
      mount.removeChild(tooltip);
      renderer.dispose();
    };
  }, [onScannerClick]);

  return <div ref={mountRef} className="h-[360px] w-full md:h-[480px]" />;
}
