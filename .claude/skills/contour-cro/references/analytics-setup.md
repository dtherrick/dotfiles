# Analytics Setup for Landing Page CRO

This guide provides step-by-step instructions for setting up essential analytics and tracking for conversion rate optimization.

---

## Analytics Stack Overview

**Essential (Set up immediately)**:
- Google Analytics 4 (GA4) - Free, comprehensive
- Google Tag Manager (GTM) - Free, flexible tracking
- Microsoft Clarity - Free heatmaps & session recordings

**Nice to Have (Add later)**:
- Hotjar - More advanced heatmaps (paid after free tier)
- Plausible/Fathom - Privacy-focused alternatives
- Mixpanel - Product analytics (for post-signup behavior)

---

## Phase 1: Google Analytics 4 Setup

### Step 1: Create GA4 Property

1. Go to analytics.google.com
2. Click "Admin" (gear icon, bottom left)
3. Click "+ Create Property"
4. Property name: "Contour SEO - Landing Page"
5. Reporting time zone: Your timezone
6. Currency: USD
7. Click "Next"
8. Choose industry category and business size
9. Select "Examine user behavior" for objectives
10. Click "Create"
11. Accept terms of service

### Step 2: Set Up Data Stream

1. In "Data streams" section, click "Add stream"
2. Select "Web"
3. Enter your website URL
4. Stream name: "Landing Page"
5. Enable "Enhanced measurement" (recommended)
6. Click "Create stream"
7. **Copy the Measurement ID** (format: G-XXXXXXXXXX)

### Step 3: Install GA4 Tracking Code

**Option A: Direct Install (Simple)**

Add this code to your `<head>` section before the closing `</head>` tag:

```html
<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-XXXXXXXXXX');
</script>
```

Replace `G-XXXXXXXXXX` with your actual Measurement ID.

**Option B: Google Tag Manager (Recommended for flexibility)**

See "Google Tag Manager Setup" section below.

### Step 4: Verify Installation

1. Visit your landing page
2. Open GA4 > Reports > Realtime
3. You should see yourself as an active user
4. If not visible after 5 minutes, check browser console for errors

---

## Phase 2: Conversion Goal Setup

### Define Your Conversion Goal

**Primary Goal**: Signup form submission

### Create Conversion Event in GA4

**Method 1: Using Enhanced Measurement (Automatic)**

If your form submission triggers a thank-you page URL:

1. GA4 > Configure > Events
2. Click "Create event"
3. Event name: `signup_complete`
4. Matching conditions:
   - Parameter: `page_location`
   - Operator: `contains`
   - Value: `/thank-you` (or your confirmation URL)
5. Click "Create"
6. Go to Configure > Conversions
7. Click "New conversion event"
8. Event name: `signup_complete`
9. Toggle to mark as conversion

**Method 2: Custom Event Tracking (Recommended)**

Add this code to your thank-you page or form submission handler:

```javascript
// When form is successfully submitted:
gtag('event', 'signup', {
  'event_category': 'engagement',
  'event_label': 'landing_page_signup'
});
```

Then mark `signup` as a conversion in GA4:
1. Configure > Conversions > New conversion event
2. Enter event name: `signup`

### Additional Conversion Events to Track

**Micro-conversions** (engagement signals):

```javascript
// Track CTA clicks (even if not form submission)
gtag('event', 'cta_click', {
  'event_category': 'engagement',
  'event_label': 'primary_cta',
  'cta_text': 'Start Free Trial'
});

// Track demo video plays
gtag('event', 'video_start', {
  'event_category': 'engagement',
  'event_label': 'landing_page_demo'
});

// Track scroll depth (if not using enhanced measurement)
// Trigger at 25%, 50%, 75%, 100% scroll
gtag('event', 'scroll', {
  'event_category': 'engagement',
  'percent_scrolled': 75
});
```

---

## Phase 3: Google Tag Manager Setup (Optional but Recommended)

### Why Use GTM?

- Add/modify tracking without code changes
- Test events before going live
- Manage multiple tracking tools in one place
- No developer needed for tag changes

### GTM Setup Steps

**1. Create GTM Container**:
1. Go to tagmanager.google.com
2. Create Account > Name: "Contour SEO"
3. Container name: "Landing Page"
4. Target platform: Web
5. Click "Create"

**2. Install GTM Code**:

Add to `<head>`:
```html
<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-XXXXXX');</script>
<!-- End Google Tag Manager -->
```

Add after opening `<body>`:
```html
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-XXXXXX"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
```

**3. Add GA4 Tag in GTM**:
1. In GTM, click "Add a new tag"
2. Tag Configuration > Google Analytics: GA4 Configuration
3. Measurement ID: G-XXXXXXXXXX
4. Triggering: All Pages
5. Save and name: "GA4 - Page View"

**4. Add Conversion Tracking Tag**:
1. New Tag > Google Analytics: GA4 Event
2. Configuration Tag: Select your GA4 Configuration tag
3. Event Name: `signup`
4. Event Parameters: Add relevant data
5. Triggering: Create trigger for form submission
6. Save

**5. Test & Publish**:
1. Click "Preview" in GTM
2. Visit your landing page in preview mode
3. Verify tags fire correctly
4. Click "Submit" > "Publish"

---

## Phase 4: Microsoft Clarity Setup (Free Heatmaps)

### Why Clarity?

- Free forever (unlimited sessions)
- Heatmaps and click maps
- Session recordings
- No impact on page speed
- Easy setup

### Setup Steps

1. Go to clarity.microsoft.com
2. Sign in with Microsoft account
3. Click "Add new project"
4. Project name: "Contour SEO Landing Page"
5. Website URL: your-site.com
6. Category: Business/Professional
7. Click "Add new project"

**Install Tracking Code**:

Copy the tracking code provided and add to `<head>`:

```html
<script type="text/javascript">
    (function(c,l,a,r,i,t,y){
        c[a]=c[a]||function(){(c[a].q=c[a].q||[]).push(arguments)};
        t=l.createElement(r);t.async=1;t.src="https://www.clarity.ms/tag/"+i;
        y=l.getElementsByTagName(r)[0];y.parentNode.insertBefore(t,y);
    })(window, document, "clarity", "script", "YOUR_PROJECT_ID");
</script>
```

**Verify Installation**:
- Visit your page
- Check Clarity dashboard for activity (may take 1-2 hours)

---

## Phase 5: UTM Parameter Setup

### Why UTM Parameters Matter

Track which traffic sources convert best:
- Email campaigns
- Social media posts
- Paid ads
- Partner links

### UTM Parameter Structure

```
https://contourseo.com/?utm_source=[source]&utm_medium=[medium]&utm_campaign=[campaign]
```

**Parameters**:
- `utm_source`: Where traffic comes from (google, newsletter, linkedin)
- `utm_medium`: Marketing medium (cpc, email, social)
- `utm_campaign`: Specific campaign (launch, beta_invite, geo_guide)
- `utm_content`: Optional, for A/B testing (cta_blue, headline_v2)
- `utm_term`: Optional, for paid keywords

### Example UTM Links

**Email campaign**:
```
https://contourseo.com/?utm_source=newsletter&utm_medium=email&utm_campaign=geo_guide
```

**LinkedIn post**:
```
https://contourseo.com/?utm_source=linkedin&utm_medium=social&utm_campaign=beta_launch
```

**Google Ad**:
```
https://contourseo.com/?utm_source=google&utm_medium=cpc&utm_campaign=ai_overview_keywords&utm_term=geo_tools
```

### UTM Best Practices

- Always lowercase
- Use underscores, not spaces
- Be consistent (choose "newsletter" or "email_newsletter", stick with it)
- Document your UTM taxonomy
- Use a URL builder: ga-dev-tools.google/campaign-url-builder/

---

## Phase 6: Essential GA4 Reports Setup

### Custom Reports to Create

**1. Landing Page Performance Report**

1. GA4 > Explore > Blank
2. Name: "Landing Page Performance"
3. Dimensions:
   - First user source/medium
   - Landing page
   - Device category
4. Metrics:
   - Sessions
   - Conversions (signup)
   - Conversion rate
   - Average engagement time
5. Save

**2. Form Abandonment Report**

Track where users drop off:

1. GA4 > Explore > Funnel exploration
2. Steps:
   - Landing page view
   - Form started (scroll to form)
   - Form submitted
3. Breakdown by Device, Source
4. Save

**3. Content Engagement Report**

See which sections get attention:

1. GA4 > Explore > Free form
2. Dimensions: Page path and screen class
3. Metrics: 
   - Average engagement time
   - Scroll depth
   - Bounce rate
4. Save

---

## Phase 7: Event Tracking Implementation

### Priority Events to Track

**High Priority**:
```javascript
// Primary CTA click
gtag('event', 'cta_click', {
  'button_location': 'hero', // or 'middle', 'footer'
  'button_text': 'Start Free Trial'
});

// Form field interaction (shows intent)
gtag('event', 'form_start', {
  'form_location': 'hero'
});

// Signup completion
gtag('event', 'signup_complete', {
  'signup_method': 'email' // or 'google_oauth'
});
```

**Medium Priority**:
```javascript
// Pricing page view (if separate)
gtag('event', 'page_view', {
  'page_location': '/pricing',
  'page_title': 'Pricing'
});

// Scroll depth milestones
gtag('event', 'scroll_depth', {
  'percent': 50
});

// Time on page milestones
gtag('event', 'engaged_user', {
  'time_threshold': 30 // seconds
});
```

**Low Priority**:
```javascript
// Feature section views
gtag('event', 'section_view', {
  'section_name': 'how_it_works'
});

// Testimonial interactions
gtag('event', 'testimonial_view', {
  'testimonial_id': 'company_a'
});
```

### Implementation Methods

**Method 1: Inline onclick handlers** (Quick & dirty):
```html
<button onclick="gtag('event', 'cta_click', {'button_location': 'hero'});">
  Start Free Trial
</button>
```

**Method 2: JavaScript event listeners** (Better):
```javascript
document.querySelector('.cta-button').addEventListener('click', function() {
  gtag('event', 'cta_click', {
    'button_location': 'hero',
    'button_text': this.textContent
  });
});
```

**Method 3: GTM** (Best for non-developers):
- Set up click triggers in GTM
- No code changes needed
- Easy to modify

---

## Phase 8: Conversion Tracking Validation

### Testing Checklist

**Before Launch**:
- [ ] GA4 tracking code installed
- [ ] Real-time reporting shows your visit
- [ ] Conversion event fires on form submission
- [ ] UTM parameters captured correctly
- [ ] GTM (if used) tags fire without errors
- [ ] Clarity recordings appear

**After Launch (First Week)**:
- [ ] Conversions appearing in GA4 (within 24-48 hours)
- [ ] Conversion source/medium data populating
- [ ] Heatmaps showing click patterns in Clarity
- [ ] Session recordings capturing user behavior
- [ ] No tracking errors in browser console

### Common Issues & Fixes

**Issue**: Events not showing in GA4
- **Check**: Browser ad blocker disabled for testing
- **Check**: Event name matches conversion event exactly
- **Check**: Code placed before closing `</head>` tag

**Issue**: Conversion rate 0%
- **Check**: Conversion event marked as conversion in GA4
- **Check**: Looking at correct date range (allow 24-48 hours)
- **Check**: Event firing on thank-you page load, not button click

**Issue**: High bounce rate (>70%)
- **Check**: GA4 measuring engagement correctly
- **Check**: Page loading properly (no errors)
- **Check**: Mobile experience not broken

---

## Tracking Privacy Considerations

### Best Practices

**Transparency**:
- Privacy policy mentions GA4, Clarity
- Cookie consent banner (if targeting EU)
- Clear data collection explanation

**Minimal Data Collection**:
- Don't track PII (emails, names) in events
- Use anonymized IPs (default in GA4)
- Don't track sensitive form fields

**Compliance**:
- GDPR: Get consent before tracking (if EU visitors)
- CCPA: Allow opt-out (if California visitors)
- Cookie policy page

---

## Analytics Maintenance Checklist

### Weekly
- [ ] Check conversion rate trends
- [ ] Review top traffic sources
- [ ] Watch 3-5 Clarity session recordings
- [ ] Identify drop-off points in funnel

### Monthly
- [ ] Deep dive into source/medium performance
- [ ] Analyze device/browser conversion differences
- [ ] Review heatmaps for engagement patterns
- [ ] Update UTM taxonomy if needed

### Quarterly
- [ ] Audit all tracking for accuracy
- [ ] Remove unused events
- [ ] Benchmark against industry standards
- [ ] Review privacy compliance

---

## Quick Reference: Testing URLs

**Test if tracking is working**:
1. Visit page in private/incognito window
2. Open browser console (F12)
3. Look for gtag or GTM messages
4. Check Network tab for `collect` or `gtm` requests
5. Verify GA4 Realtime shows your visit

**Debug checklist**:
- [ ] Tracking code in `<head>` section
- [ ] Measurement ID correct
- [ ] No JavaScript errors in console
- [ ] Ad blockers disabled for testing
- [ ] Cookies enabled in browser
