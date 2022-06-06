import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ColorDetectionComponent } from './color-detection.component';

describe('ColorDetectionComponent', () => {
  let component: ColorDetectionComponent;
  let fixture: ComponentFixture<ColorDetectionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ColorDetectionComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ColorDetectionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
